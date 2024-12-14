local DATA_STORE_SERVICE = game:GetService("DataStoreService")
local Guard = require(game.ReplicatedStorage.Packages.Guard)
local DocumentService = require(game.ReplicatedStorage.Packages.DocumentService)

type DataSchema = {
	coins: number,
}

local DataInterface = {
	coins = Guard.Integer,
}

local function dataCheck(value: unknown): DataSchema
	assert(type(value) == "table", "Data must be a table")
	local Value: any = value

	return {
		coins = DataInterface.coins(Value.coins),
	}
end

local store = DocumentService.DocumentStore.new({
	dataStore = DATA_STORE_SERVICE:GetDataStore("Coins") :: any,
	check = Guard.Check(dataCheck),
	default = {
		coins = 0,
	},
	migrations = {},
	lockSessions = true,
})

return store
