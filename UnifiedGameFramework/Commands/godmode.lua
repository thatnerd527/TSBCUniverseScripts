local module = {
	execute=function (command,args,authorized,player)
		local gamesys = require(script.Parent.Parent)
		if (authorized) then
      local humanoid = player.Character:WaitForChild("Humanoid")
      humanoid.HealthChanged:Connect(function ()
        humanoid.Health = humanoid.MaxHealth  
      end)
		else
			gamesys.SendTextToChat(player,"No permission to run this command.")
		end
	end,
	syntax=function (prefix)
		return "(admin only) "..prefix..script.Name.." "
	end,
	description=function (prefix)
		return "This command will enable invulnerabillity, until respawn character."
	end
}

return module
