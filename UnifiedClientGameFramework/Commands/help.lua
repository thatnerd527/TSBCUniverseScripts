local module = {
	execute=function (command,args,authorized,player)
		if (args == "") then
			local help = require(script.Parent.Parent).GetHelp()
			local assembled = ""
			for i,v in pairs(help) do
				assembled = assembled.."(client command) "..v.shorthelp.."\n"
			end
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
				Text = assembled,
			})
		else
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
				Text = require(script.Parent.Parent).GetPerCommandHelp(args),
			})
		end
	end,
	syntax=function (prefix)
		return prefix..script.Name.." [command]"
	end,
	description=function (prefix)
		return "This command will show how to use a command"
	end,
}

return module
