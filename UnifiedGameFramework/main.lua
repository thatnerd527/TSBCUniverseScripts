-- Define the command prefix
local prefix = "!"
local Utils = require(game:GetService("ReplicatedStorage"):WaitForChild("TNUtils"))
local chat = game.Chat
local commands = {}
local inited = false

function recursiveremove(children) 
	for i,v in pairs(children) do
		if v:IsA("ModuleScript") then
      print(require(v))
			commands[v.Name] = {
				run=require(v).execute,
				shorthelp=require(v).syntax,
				longhelp=require(v).description
			}
			--print(v.Name.." welded")
		end

		recursiveremove(v:GetChildren())
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
			commands[command].run(command,args,authorized,player)
		end
		
	end
end

if (not inited) then
	recursiveremove(script.Commands:GetChildren())
	-- Connect the function to the Chat event of the chat bar
	game.Players.PlayerAdded:Connect(function (player)
		player.Chatted:Connect(function (message)
			
			onChat(message,player)
		end)
	end)
	game:GetService("Chat"):RegisterChatCallback(Enum.ChatCallbackType.OnServerReceivingMessage,function (m)
		if (m.Message:sub(1, prefix:len()) == prefix) then
			m.ShouldDeliver = false
			return m
		end
		return m
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
	SendTextToChat=function (player,text)
		game:GetService("ReplicatedStorage").SystemMessageClient:InvokeClient(player,text)
	end,
}


