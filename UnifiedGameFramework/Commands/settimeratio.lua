local module = {
	execute=function (command,args,authorized,player)
		local gamesys = require(script.Parent.Parent)
		if (authorized) then
			gamesys.SendTextToChat(player,"Time ratio / speed set to: "..args)
			require(script.Parent.Parent.Systems.Time).settimeratio(args,gamesys,player)
		else
			gamesys.SendTextToChat(player,"No permission to run this command.")
		end
	end,
	syntax=function (prefix)
		return "(admin only) "..prefix..script.Name.." (time multipliter)"
	end,
	description=function (prefix)
		return "This command will set time ratio / speed."
	end
}

return module
