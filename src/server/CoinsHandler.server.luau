local CoinsNamespace = require(game.ReplicatedStorage.Shared.namespaces.coins)

-------------------------------------------------------------------------------
-- Packet Listeners
-------------------------------------------------------------------------------
CoinsNamespace.addCoins.listen(function(data, player)
	if not player then
		return
	end
	if not player:FindFirstChild("leaderstats") then
		warn("No leaderstats found for player: " .. player.Name)
		return
	end
	local coins = player:WaitForChild("leaderstats"):FindFirstChild("Coins")
	if not coins then
		warn("No coins found for player: " .. player.Name)
		return
	end
	print("Adding " .. data.amount .. " coins to player: " .. player.Name)
	coins.Value += data.amount
end)

CoinsNamespace.removeCoins.listen(function(data, player)
	if not player then
		return
	end
	if not player:FindFirstChild("leaderstats") then
		warn("No leaderstats found for player: " .. player.Name)
		return
	end
	local coins = player:WaitForChild("leaderstats"):FindFirstChild("Coins")
	if not coins then
		warn("No coins found for player: " .. player.Name)
		return
	end
	print("Removing " .. data.amount .. " coins from player: " .. player.Name)
	coins.Value -= data.amount
end)

CoinsNamespace.resetCoins.listen(function(data, player)
	if not player then
		return
	end
	print("Resetting coins for player: " .. player.Name)
	if not player:FindFirstChild("leaderstats") then
		warn("No leaderstats found for player: " .. player.Name)
		return
	end
	local coins = player:WaitForChild("leaderstats"):FindFirstChild("Coins")
	if not coins then
		warn("No coins found for player: " .. player.Name)
		return
	end
	coins.Value = 0
end)
