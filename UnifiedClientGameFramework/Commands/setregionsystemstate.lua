local module = {
	execute=function (command,args,authorized,player)
    game:GetService("Players").LocalPlayer.PlayerScripts.RegionSystem3.SetState:Fire(args)
	end,
	syntax=function (prefix)
		return prefix..script.Name.." (true|false)"
	end,
	description=function (prefix)
		return "This command will enable / disable region system."
	end,
}

return module
