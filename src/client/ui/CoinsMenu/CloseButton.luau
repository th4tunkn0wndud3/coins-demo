local React = require(game.ReplicatedStorage.Packages.React)
local ReactSpring = require(game.ReplicatedStorage.Packages.ReactSpring)
local Assets = require(game.ReplicatedStorage.Shared.libs.assets)

local e = React.createElement

local function CloseButton(props: {
	position: UDim2?,
	onClick: () -> (),
})
	local style, api = ReactSpring.useSpring(function()
		return {
			Rotation = 20,
		}
	end)
	return e("TextButton", {
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		Size = UDim2.fromScale(50 / 841, 50 / 518),
		AnchorPoint = Vector2.new(0.5, 0.5),
		AutoButtonColor = false,
		Position = props.position or UDim2.fromScale(1, 0),
		Rotation = style.Rotation,
		Text = "", -- Create a text label so text doesn't get affected by gradient
		Font = Enum.Font.FredokaOne,
		TextSize = 48,
		TextColor3 = Color3.fromRGB(255, 255, 255),
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
				Rotation = 25,
			})
		end,
		[React.Event.MouseLeave] = function()
			api.start({
				Rotation = 20,
			})
		end,
	}, {
		text = e("TextLabel", {
			Text = "X",
			TextSize = 48,
			TextScaled = true,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Font = Enum.Font.FredokaOne,
		}),
		corner = e("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),
		stroke = e("UIStroke", {
			Color = Color3.fromRGB(0, 0, 0),
			Thickness = 2,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		}),
		gradient = e("UIGradient", {
			Rotation = 90,
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHex("#E82C2C")),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#F96262")),
			}),
		}),
	})
end

return CloseButton
