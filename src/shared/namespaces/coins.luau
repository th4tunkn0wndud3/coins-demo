local ByteNet = require(game.ReplicatedStorage.Packages.ByteNet)

return ByteNet.defineNamespace("coins", function()
	return {
		addCoins = ByteNet.definePacket({
			value = ByteNet.struct({
				amount = ByteNet.int32,
			}),
		}),
		removeCoins = ByteNet.definePacket({
			value = ByteNet.struct({
				amount = ByteNet.int32,
			}),
		}),
		resetCoins = ByteNet.definePacket({
			value = ByteNet.struct({}),
		}),
	}
end)
