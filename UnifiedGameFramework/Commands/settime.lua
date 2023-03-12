local module = {
	execute=function (command,args,authorized,player)
		local gamesys = require(script.Parent.Parent)
		if (authorized) then
			gamesys.SendTextToChat(player,"Time set to: "..args)
			
			require(script.Parent.Parent.Systems.Time).settimefmt(args,gamesys,player)
		else
			gamesys.SendTextToChat(player,"No permission to run this command.")
		end
	end,
	syntax=function (prefix)
		return "(admin only) "..prefix..script.Name.." h:m:s (or) hh:mm:ss"
	end,
	description=function (prefix)
		return "This command will set the time based on 24hr format"
	end
}

return module
