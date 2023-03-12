script.Parent.Equipped:Connect(function()
	game.Players.LocalPlayer.PlayerGui["Ragdoll & Get Up"].Enabled = true
  game.Players.LocalPlayer.PlayerGui["UI"].Enabled = true
end)

script.Parent.Unequipped:Connect(function ()
  game.Players.LocalPlayer.PlayerGui["Ragdoll & Get Up"].Enabled = false
  game.Players.LocalPlayer.PlayerGui["UI"].Enabled = false
end)

