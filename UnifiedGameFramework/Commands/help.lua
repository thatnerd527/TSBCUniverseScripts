

local module = {
	execute=function (command,args,authorized,player)
		local gamesys = require(script.Parent.Parent)
		if (args == "") then
			local help = require(script.Parent.Parent).GetHelp()
			local assembled = ""
			for i,v in pairs(help) do
				assembled = assembled.."(server command) "..v.shorthelp.."\n"
			end
			gamesys.SendTextToChat(player,assembled)
		else
			gamesys.SendTextToChat(player,gamesys.GetPerCommandHelp(args))
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
