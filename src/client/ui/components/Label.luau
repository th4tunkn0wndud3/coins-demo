local React = require(game.ReplicatedStorage.Packages.React)

local e = React.createElement

local function Label(props: {
	text: string,
	textSize: number,
	size: UDim2,
	position: UDim2?,

	anchorPoint: Vector2?,
	textX: Enum.TextXAlignment?,
	textY: Enum.TextYAlignment?,
	font: Enum.Font?,
})
	return e("TextLabel", {
		Text = props.text,
		TextSize = props.textSize or 16,
		TextScaled = true,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Size = props.size,
		Position = props.position,
		BackgroundTransparency = 1,
		TextXAlignment = props.textX or Enum.TextXAlignment.Center,
		TextYAlignment = props.textY or Enum.TextYAlignment.Center,
		Font = props.font or Enum.Font.FredokaOne,
		AnchorPoint = props.anchorPoint or Vector2.new(0.5, 0.5),
	}, {
		stroke = e("UIStroke", {
			Color = Color3.fromRGB(0, 0, 0),
		}),
		textSizeConstraint = e("UITextSizeConstraint", {
			MaxTextSize = props.textSize or 16,
			MinTextSize = 1,
		}),
	})
end

return Label
