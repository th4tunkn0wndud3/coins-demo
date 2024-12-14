local React = require(game.ReplicatedStorage.Packages.React)

local Label = require(script.Parent.components.Label)
local Input = require(script.Parent.components.Input)
local Button = require(script.Parent.components.Button)

local CloseButton = require(script.CloseButton)

local e = React.createElement

local function CoinsMenu(props: {
	coins: number,
	callback: (number?, boolean?) -> (),
})
	local value, setValue = React.useState(0)
	return e("Frame", {
		Size = UDim2.fromScale(841 / 1920, 518 / 1080),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
	}, {
		title = e(Label, {
			text = "Coins Menu",
			size = UDim2.fromScale(289 / 841, 50 / 518),
			textSize = 48,
			anchorPoint = Vector2.new(0, 0.5),
		}),
		close = e(CloseButton, {
			onClick = function()
				props.callback(nil, nil)
			end,
		}),
		coinsInput = e(Input, {
			placeholder = "Enter Coins Amount",
			numberOnly = true,
			setValue = setValue,
			position = UDim2.fromScale(0.5, 422 / 1080),
			size = UDim2.fromScale(414 / 841, 56 / 518),
			anchorPoint = Vector2.new(0.5, 1),
		}),
		addButton = e(Button, {
			text = "Add Coins",
			onClick = function()
				if value == 0 then
					return
				end
				props.callback(value, true)
			end,
			position = UDim2.fromScale(0.325, 460 / 1080),
			size = UDim2.fromScale(268 / 841, 56 / 518),
			color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHex("#2CE82C")),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#62F962")),
			}),
			anchorPoint = Vector2.new(0.5, 0),
		}),
		removeButton = e(Button, {
			text = "Remove Coins",
			onClick = function()
				if value == 0 then
					return
				end
				props.callback(value, false)
			end,
			position = UDim2.fromScale(0.675, 460 / 1080),
			size = UDim2.fromScale(268 / 841, 56 / 518),
			color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHex("#E82C2C")),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#F96262")),
			}),
			anchorPoint = Vector2.new(0.5, 0),
		}),
		resetButton = e(Button, {
			text = "Reset Coins",
			onClick = function()
				props.callback(0, nil)
			end,
			position = UDim2.fromScale(0.5, 600 / 1080),
			size = UDim2.fromScale(268 / 841, 56 / 518),
			color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHex("#E82C2C")),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#F96262")),
			}),
			anchorPoint = Vector2.new(0.5, 0),
		}),
		corner = e("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),
		ratioConstraint = e("UIAspectRatioConstraint", {
			AspectRatio = 841 / 518,
		}),
		stroke = e("UIStroke", {
			Color = Color3.fromRGB(0, 0, 0),
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Thickness = 4,
		}),
	})
end

return CoinsMenu
