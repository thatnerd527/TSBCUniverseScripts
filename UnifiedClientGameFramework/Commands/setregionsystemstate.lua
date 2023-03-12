local module = {
	execute=function (command,args,authorized,player)
		require(script.Parent.Parent.Systems.RegionSystem).setenabled(args)
	end,
	syntax=function (prefix)
		return prefix..script.Name.." (true|false)"
	end,
	description=function (prefix)
		return "This command will enable / disable region system."
	end,
}

return module
