--[=[
	@class Switch

	A toggle switch which can be turned on or off, usually used to enable or disable a setting.
	The `Label` prop should be used to indicate the purpose of the switch.

	| Dark | Light |
	| - | - |
	| ![Dark](/StudioCreator/components/switch/dark.png) | ![Light](/StudioCreator/components/switch/light.png) |

	As this is a controlled component, you should pass a value to the `Value` prop representing
	whether the switch is on, and a callback to the `OnChanged` prop which gets run when the
	user interacts with the switch. For example:

	```lua
	local function MyComponent()
		local enabled, setEnabled = React.useState(false)
		return React.createElement(StudioCreator.Switch, {
			Value = enabled,
			OnChanged = function()
				setEnabled(not enabled)
			end,
		})
	end
	```

	The default height of a switch, including its label, can be found in [Constants.DefaultToggleHeight].
	The size of the whole switch can be overridden by passing a value to the `Size` prop.
]=]

local React = require("@pkg/@jsdotlua/react")

local CommonProps = require("../CommonProps")
local Constants = require("../Constants")
local useTheme = require("../Hooks/useTheme")

local SWITCH_WIDTH = 28
local SWITCH_HEIGHT = 16
local THUMB_SIZE = 14
local TRACK_PADDING = 1
local INNER_PADDING = 6

--[=[
	@within Switch
	@interface Props
	@tag Component Props

	@field ... CommonProps
	@field Value boolean?
	@field OnChanged (() -> ())?
	@field Label string?
]=]

type SwitchProps = CommonProps.T & {
	Value: boolean?,
	OnChanged: (() -> ())?,
	Label: string?,
}

local function Switch(props: SwitchProps)
	local theme = useTheme()
	local hovered, setHovered = React.useState(false)

	local mainModifier = Enum.StudioStyleGuideModifier.Default
	if props.Disabled then
		mainModifier = Enum.StudioStyleGuideModifier.Disabled
	elseif hovered then
		mainModifier = Enum.StudioStyleGuideModifier.Hover
	end

	local trackStyle = if props.Value == true
		then Enum.StudioStyleGuideColor.DialogMainButton
		else Enum.StudioStyleGuideColor.InputFieldBackground

	local trackTransparency = if props.Value == true then 0
		elseif props.Disabled then 0.6
		else 0

	local thumbTransparency = if props.Disabled then 0.5 else 0

	local thumbX = if props.Value == true
		then SWITCH_WIDTH - THUMB_SIZE - TRACK_PADDING
		else TRACK_PADDING

	local function inputBegan(_: TextButton, input: InputObject)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			setHovered(true)
		end
	end

	local function inputEnded(_: TextButton, input: InputObject)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			setHovered(false)
		end
	end

	local function activated()
		if not props.Disabled and props.OnChanged then
			props.OnChanged()
		end
	end

	return React.createElement("TextButton", {
		Size = props.Size or UDim2.new(1, 0, 0, Constants.DefaultToggleHeight),
		Position = props.Position,
		AnchorPoint = props.AnchorPoint,
		LayoutOrder = props.LayoutOrder,
		ZIndex = props.ZIndex,
		BackgroundTransparency = 1,
		Text = "",
		[React.Event.InputBegan] = inputBegan,
		[React.Event.InputEnded] = inputEnded,
		[React.Event.Activated] = activated,
	}, {
		Layout = React.createElement("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, INNER_PADDING),
		}),
		Label = props.Label and React.createElement("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -SWITCH_WIDTH - INNER_PADDING, 1, 0),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Text = props.Label,
			Font = Constants.DefaultFont,
			TextSize = Constants.DefaultTextSize,
			TextColor3 = theme:GetColor(Enum.StudioStyleGuideColor.MainText, mainModifier),
			LayoutOrder = 1,
		}),
		Track = React.createElement("Frame", {
			Size = UDim2.fromOffset(SWITCH_WIDTH, SWITCH_HEIGHT),
			BackgroundColor3 = theme:GetColor(trackStyle, mainModifier),
			BackgroundTransparency = trackTransparency,
			BorderSizePixel = 0,
			LayoutOrder = 2,
		}, {
			Corner = React.createElement("UICorner", {
				CornerRadius = UDim.new(0.5, 0),
			}),
			Stroke = React.createElement("UIStroke", {
				Color = theme:GetColor(Enum.StudioStyleGuideColor.Border, mainModifier),
				Transparency = 0,
			}),
			Thumb = React.createElement("Frame", {
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, thumbX, 0.501, 0),
				Size = UDim2.fromOffset(THUMB_SIZE, THUMB_SIZE),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = thumbTransparency,
				BorderSizePixel = 0,
			}, {
				Corner = React.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
				Shadow = React.createElement("UIStroke", {
					Color = Color3.fromRGB(0, 0, 0),
					Transparency = 0.8,
					Thickness = 0.5,
				}),
			}),
		}),
	})
end

return Switch
