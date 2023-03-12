local currentdensity = game.Lighting.Atmosphere.Density

local module = {
	execute=function (command,args,authorized,player)
		if (args == "true") then
			game.Lighting.Atmosphere.Density = currentdensity
		else
			game.Lighting.Atmosphere.Density = 0
		end
	end,
	syntax=function (prefix)
		return prefix..script.Name.." [command]"
	end,
	description=function (prefix)
		return "This command will enable or disable fog."
	end,
}

return module
