local PLAYERS = game:GetService("Players")

local Store = require(script.Parent.Data.Store)

-------------------------------------------------------------------------------
-- Player Join
-------------------------------------------------------------------------------
PLAYERS.PlayerAdded:Connect(function(player: Player)
	-- prevent dupes
	if player:FindFirstChild("leaderstats") then
		return
	end
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	-- prevent dupes
	if player:FindFirstChild("coins") then
		return
	end
	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Parent = leaderstats
	coins.Value = 0

	local document = Store:GetDocument(tostring(player.UserId))
	local result = document:Open()
	if not result.success and result.reason == "SessionLockedError" then
		document:Steal()
		result = document:Open()
	end

	if not result.success then
		if result.reason == "BackwardsCompatibilityError" then
			player:Kick(
				"You joined an old server which does not support your saved data."
					.. "Please try joining another server. If this persists, contact a developer."
			)
		end

		if result.reason == "RobloxAPIError" then
			player:Kick("Failed to load data due to a Roblox service issue. Try again later.")
		end

		player:Kick(
			`Failed to load data: {result.reason}. Please screenshot this message and report it to a developer.`
		)

		return false
	end

	coins.Value = result.data.coins
end)

-------------------------------------------------------------------------------
-- Player Leave
-------------------------------------------------------------------------------
PLAYERS.PlayerRemoving:Connect(function(player: Player)
	local document = Store:GetDocument(tostring(player.UserId))

	local cache = table.clone(document:GetCache())
	cache.coins = player:WaitForChild("leaderstats"):WaitForChild("Coins").Value

	document:SetCache(cache)
	document:Close()
end)
