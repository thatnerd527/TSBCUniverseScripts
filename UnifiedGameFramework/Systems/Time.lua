
local maxtime = script.HowManySecondsInADay.Value
local ratio = script.TimeSpeedMultiplier.Value
local time = script.StartTime.Value / ratio
local RunService = game:GetService("RunService")
local enabletime = true
print("Start time: "..time)
RunService.Stepped:Connect(function (time2,deltatime)
	if (enabletime) then
		local scaledtime = time * ratio
		local h = math.floor(scaledtime / 3600)
		local m = math.floor((scaledtime / 60) % 60)
		local s = math.floor(scaledtime % 60)

		time = time + deltatime
		time = time % maxtime
		if h < 10  then
			h = "0"..h
		end
		if m < 10  then
			m = "0"..m
		end
		if s < 10  then
			s = "0"..s
		end
		game.Lighting.TimeOfDay = h..":"..m..":"..s
	end
end)

local module = {
	settime=function (args)

		game.Lighting.ClockTime = (tonumber(args) / ratio) / 3600
		time = tonumber(args) / ratio
	end,
	settimefmt=function (args,gamesys,player)
		local split = string.split(args,":")
		local h = tonumber(split[1])
		local m = tonumber(split[2])
		local s = tonumber(split[3])
		local totalseconds = s + (m * 60) + (h*3600)
		gamesys.SendTextToChat(player,"Internal format (before ratio): "..totalseconds)
		time = totalseconds / ratio
		game.Lighting.ClockTime = (totalseconds / ratio) / 3600
		gamesys.SendTextToChat(player,"Internal format (after ratio): "..time)
	end,
	settimestate=function (args)

		if args == "true" then
			enabletime = true
		else
			enabletime = false
		end
	end,
	settimeratio=function (args,gamesys,player)
		time = (time * ratio) / tonumber(args)
		ratio = tonumber(args)
		
	end,
}

return module
