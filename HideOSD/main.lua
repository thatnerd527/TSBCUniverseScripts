script.Parent.Equipped:Connect(function()
	game.Players.LocalPlayer.PlayerGui["Ragdoll & Get Up"].Enabled = true
end)

script.Parent.Unequipped:Connect(function ()
  game.Players.LocalPlayer.PlayerGui["Ragdoll & Get Up"].Enabled = false
end)

