script.Parent.Equipped:Connect(function()
    print("eb t")
	game.Players.LocalPlayer.PlayerGui["Ragdoll & Get Up"].Enabled = true
end)

script.Parent.Unequipped:Connect(function ()
  print("eb f")
  game.Players.LocalPlayer.PlayerGui["Ragdoll & Get Up"].Enabled = false
end)

