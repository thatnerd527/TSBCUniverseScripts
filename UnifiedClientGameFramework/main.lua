-- Define the command prefix
local prefix = "!"
local Utils = require(game:GetService("ReplicatedStorage"):WaitForChild("TNUtils"))
local commands = {}
local inited = false

function recursiveremove(children) 
	for i,v in pairs(children) do
		if v:IsA("ModuleScript") and not string.find(v.Name,".modloader-internal",0,true) then
			--print(require(v))
			--print("BREAK")
			--print(v.Name)
			commands[v.Name] = {
				run=require(v)["execute"],
				shorthelp=require(v)["syntax"],
				longhelp=require(v)["description"]
			}
			--print(v.Name.." welded")
		end
		if not string.find(v.Name,".modloader-internal",0,true) then
			recursiveremove(v:GetChildren())
		end
	end
end



-- Create a function to handle chat messages
local function onChat(message,player)
	-- Check if the message starts with the command prefix
	if message:sub(1, prefix:len()) == prefix then
		-- Extract the command and arguments from the message

		local command, args = message:sub(prefix:len() + 1):match("^(%S+)%s*(.-)%s*$")
		local authorized = player:GetRoleInGroup(12527710) == "CEO Of TSBC" or
			player:GetRoleInGroup(12527710) == "Admin/Bots" or 
			player:GetRoleInGroup(12527710) == "TSBC Employees"
		--print(command)
		if Utils.keyisintable(commands,command) then
			commands[command].run(command,args,authorized,player,prefix)
		end

	end
end

if (not inited) then
	print("CLient Game framework ready")
	recursiveremove(script.Commands:GetChildren())
	game:GetService("ReplicatedStorage").SystemMessageClient.OnClientInvoke = function (args)
		game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
			Text = args,
		})
	end
	-- Connect the function to the Chat event of the chat bar
	game.Players.LocalPlayer.Chatted:Connect(function (message)
		onChat(message,game.Players.LocalPlayer)
	end)
	inited = true
end

return {	
	GetHelp=function ()
		local compiled = {}
		for i,v in pairs(commands) do
			compiled[i] = {
				shorthelp=v.shorthelp(prefix),
				longhelp=v.longhelp(prefix)
			}
		end
		return compiled
	end,
	GetPerCommandHelp=function (command)
		if (Utils.keyisintable(commands,command)) then
			return "Command: "..commands[command].shorthelp(prefix).."\n"..commands[command].longhelp(prefix)
		else
			return "The command '"..command.."' was not found."
		end
	end,
}


