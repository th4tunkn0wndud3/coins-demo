local React = require(game.ReplicatedStorage.Packages.React)
local ReactRoblox = require(game.ReplicatedStorage.Packages.ReactRoblox)
local CoinsMenu = require(script.Parent.Parent.CoinsMenu)

local e = React.createElement

return function(parent: Instance)
	local root = ReactRoblox.createRoot(parent)
	root:render(e(React.StrictMode, {}, {
		CoinsMenu = e(CoinsMenu, {
			coins = 0,
			callback = function(coins, isAdd)
				print("Coins: " .. tostring(coins), "IsAdd: " .. tostring(isAdd))
			end,
		}),
	}))

	return function()
		root:unmount()
	end
end
