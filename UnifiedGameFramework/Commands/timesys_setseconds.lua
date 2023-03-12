local module = {
	execute=function (command,args,authorized,player)
		local gamesys = require(script.Parent.Parent)
		if (authorized) then
			require(script.Parent.Parent.Systems.Time).settime(args)
		else
			gamesys.SendTextToChat(player,"No permission to run this command.")
		end
	end,
	syntax=function (prefix)
		return "(admin only) "..prefix..script.Name.." (true|false)"
	end,
	description=function (prefix)
		return "This command will set time in seconds (not ratio compensated)."
	end
}

return module
