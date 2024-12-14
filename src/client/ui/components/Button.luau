local React = require(game.ReplicatedStorage.Packages.React)
local ReactSpring = require(game.ReplicatedStorage.Packages.ReactSpring)
local Assets = require(game.ReplicatedStorage.Shared.libs.assets)

local e = React.createElement

local function Button(props: {
	text: string,
	size: UDim2,
	position: UDim2,
	color: Color3 | ColorSequence,

	onClick: () -> (),
	anchorPoint: Vector2?,
})
	local style, api = ReactSpring.useSpring(function()
		return {
			position = props.position,
		}
	end)
	return e("TextButton", {
		Text = "", -- Create a text label so text doesn't get affected by gradient
		Size = props.size,
		Position = style.position,
		BackgroundColor3 = if typeof(props.color) == "Color3" then props.color else Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		AutoButtonColor = false,
		AnchorPoint = props.anchorPoint or Vector2.new(0.5, 0.5),
		[React.Event.Activated] = function()
			local sfx = Instance.new("Sound")
			sfx.Parent = game:GetService("SoundService")
			sfx.Name = "Click"
			sfx.SoundId = Assets["sounds/click"]

			sfx:Play()
			sfx.Ended:Connect(function()
				sfx:Destroy()
			end)

			props.onClick()

			task.wait(3)
			if sfx then
				sfx:Destroy()
			end
		end,
		[React.Event.MouseEnter] = function()
			api.start({
				position = props.position + UDim2.fromOffset(0, -5),
			})
		end,
		[React.Event.MouseLeave] = function()
			api.start({
				position = props.position,
			})
		end,
	}, {
		text = e("TextLabel", {
			Text = props.text,
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Font = Enum.Font.FredokaOne,
			TextSize = 32,
		}, {
			stroke = e("UIStroke", {
				Color = Color3.fromRGB(0, 0, 0),
				ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			}),
		}),
		gradient = typeof(props.color) == "ColorSequence" and e("UIGradient", {
			Color = props.color,
			Rotation = 90,
		}),
		stroke = e("UIStroke", {
			Color = Color3.fromRGB(0, 0, 0),
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		}),
		corner = e("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),
	})
end

return Button
