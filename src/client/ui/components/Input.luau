local React = require(game.ReplicatedStorage.Packages.React)

local e = React.createElement

local function Input(props: {
	placeholder: string?,
	numberOnly: boolean?,
	anchorPoint: Vector2?,
	setValue: (number) -> (),

	position: UDim2,
	size: UDim2,
})
	return e("TextBox", {
		PlaceholderText = props.placeholder,
		Size = props.size,
		Position = props.position,
		AnchorPoint = props.anchorPoint or Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromHex("#B5B5B5"),
		BorderSizePixel = 0,
		TextSize = 24,
		TextXAlignment = Enum.TextXAlignment.Center,
		Text = "",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
		Font = Enum.Font.FredokaOne,
		ClearTextOnFocus = false,
		[React.Change.Text] = function(rbx)
			if props.numberOnly then
				local text = rbx.Text
				local newText = text:gsub("%D", "")
				rbx.Text = newText
			end
		end,
		[React.Event.FocusLost] = function(rbx)
			local text = rbx.Text
			local number = tonumber(text)
			if number then
				props.setValue(number)
			end
		end,
	}, {
		corner = e("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),
		stroke = e("UIStroke", {
			Color = Color3.fromRGB(0, 0, 0),
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		}),
	})
end

return Input
