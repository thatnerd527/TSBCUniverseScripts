

local module = {
	enable=function ()
		game.Players.LocalPlayer.PlayerGui.PerfDebug.Enabled = true
	end,
	disable=function ()
		game.Players.LocalPlayer.PlayerGui.PerfDebug.Enabled = false
	end,
}

return module
