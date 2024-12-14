local USER_INPUT_SERVICE = game:GetService("UserInputService")

local Assets = require(game.ReplicatedStorage.Shared.libs.assets)
local CoinMenu = require(script.Parent.ui.CoinsMenu)
local CoinsNamespace = require(game.ReplicatedStorage.Shared.namespaces.coins)
local React = require(game.ReplicatedStorage.Packages.React)
local ReactRoblox = require(game.ReplicatedStorage.Packages.ReactRoblox)

local e = React.createElement

local root: ReactRoblox.RootType?
local handle: ScreenGui?

USER_INPUT_SERVICE.InputBegan:Connect(function(keyCode, gpe)
	if gpe then
		return
	end
	if keyCode.KeyCode == Enum.KeyCode.F then
		if root and handle then
			root:unmount()
			handle:Destroy()
			root = nil
			handle = nil
		else
			handle = Instance.new("ScreenGui")
			if not handle then
				return
			end
			handle.Name = "Handle"
			handle.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
			handle.IgnoreGuiInset = true

			root = ReactRoblox.createRoot(handle)
			-- sorry for the nesting :(
			if root then
				root:render(e(React.StrictMode, {}, {
					CoinMenu = e(CoinMenu, {
						coins = 0,
						callback = function(coins, isAdd)
							if coins and coins >= 2147483648 or coins and coins <= -2147483648 then
								local sfx = Instance.new("Sound")
								sfx.Parent = game:GetService("SoundService")
								sfx.Name = "Click"
								sfx.SoundId = Assets["sounds/error"]

								sfx:Play()
								sfx.Ended:Connect(function()
									sfx:Destroy()
								end)
								warn("Coins amount is too high!")
								return
							end

							if not coins and not isAdd then
								root:unmount()
								handle:Destroy()
								root = nil
								handle = nil
							elseif coins and isAdd then
								CoinsNamespace.addCoins.send({
									amount = coins,
								})
							elseif (coins ~= 0 and coins) and not isAdd then
								CoinsNamespace.removeCoins.send({
									amount = coins,
								})
							elseif coins == 0 and not isAdd then
								CoinsNamespace.resetCoins.send({})
							end
						end,
					}),
				}))
			end
		end
	end
end)
