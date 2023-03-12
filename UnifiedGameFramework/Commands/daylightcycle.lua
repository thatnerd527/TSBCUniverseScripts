local module = {
	execute=function (command,args,authorized,player)
		local gamesys = require(script.Parent.Parent)
		if (authorized) then
			gamesys.SendTextToChat(player,"Daylight cycle set to: "..args)
			require(script.Parent.Parent.Systems.Time).settimestate(args)
		else
			gamesys.SendTextToChat(player,"No permission to run this command.")
		end
	end,
	syntax=function (prefix)
		return "(admin only) "..prefix..script.Name.." (true|false)"
	end,
	description=function (prefix)
		return "This command will toggle daylight cycle."
	end
}

return module
