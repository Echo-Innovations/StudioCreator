--[=[
	@class Tooltip

	Wraps a target element and displays a tooltip at the bottom-right of the cursor
	when the mouse hovers over it. The tooltip is styled to match built-in Studio tooltips.

	| Dark | Light |
	| - | - |
	| ![Dark](/StudioCreator/components/tooltip/dark.png) | ![Light](/StudioCreator/components/tooltip/light.png) |

	The target element to wrap is passed via `children`. The tooltip text is passed via
	the `Text` prop. For example:

	```lua
	local function MyComponent()
		return React.createElement(StudioCreator.Tooltip, {
			Text = "Click to save your changes",
		}, {
			React.createElement(StudioCreator.Button, {
				Text = "Save",
			})
		})
	end
	```

	The tooltip appears when the mouse enters the target area and follows the cursor
	until the mouse leaves. It automatically clamps to stay within the parent frame bounds.
]=]

local React = require("@pkg/@jsdotlua/react")

local CommonProps = require("../CommonProps")
local Constants = require("../Constants")
local getTextSize = require("../getTextSize")
local useTheme = require("../Hooks/useTheme")

local TOOLTIP_OFFSET_X = 12
local TOOLTIP_OFFSET_Y = 12
local TOOLTIP_PADDING_X = 6
local TOOLTIP_PADDING_Y = 4
local SHADOW_OFFSET = 1

--[=[
	@within Tooltip
	@interface Props
	@tag Component Props

	@field ... CommonProps
	@field Text string
	@field TooltipZIndex number?
	@field children React.ReactNode
]=]

type TooltipProps = CommonProps.T & {
	Text: string,
	TooltipZIndex: number?,
	children: React.ReactNode,
}

local function Tooltip(props: TooltipProps)
	local theme = useTheme()
	local hovered, setHovered = React.useState(false)
	local mousePos, setMousePos = React.useState(Vector2.new(0, 0))
	local rootRef = React.useRef(nil :: Frame?)

	local textSize = getTextSize(props.Text)
	local tooltipWidth = textSize.X + TOOLTIP_PADDING_X * 2
	local tooltipHeight = textSize.Y + TOOLTIP_PADDING_Y * 2

	local function inputBegan(_: Frame, input: InputObject)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			setHovered(true)
			setMousePos(input.Position)
		end
	end

	local function inputChanged(_: Frame, input: InputObject)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			setMousePos(input.Position)
		end
	end

	local function inputEnded(_: Frame, input: InputObject)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			setHovered(false)
		end
	end

	local modifier = Enum.StudioStyleGuideModifier.Default
	if props.Disabled then
		modifier = Enum.StudioStyleGuideModifier.Disabled
	end

	local tooltipPosition = UDim2.fromOffset(0, 0)
	if hovered and rootRef.current then
		local ancestor = rootRef.current :: GuiObject
		while ancestor.Parent and ancestor.Parent:IsA("GuiObject") do
			ancestor = ancestor.Parent :: GuiObject
		end
		local rootAbs = rootRef.current.AbsolutePosition
		local maxX = ancestor.AbsolutePosition.X + ancestor.AbsoluteSize.X - rootAbs.X
		local maxY = ancestor.AbsolutePosition.Y + ancestor.AbsoluteSize.Y - rootAbs.Y

		local x = mousePos.X - rootAbs.X + TOOLTIP_OFFSET_X
		local y = mousePos.Y - rootAbs.Y + TOOLTIP_OFFSET_Y

		if x + tooltipWidth > maxX then
			x = mousePos.X - rootAbs.X - tooltipWidth - TOOLTIP_OFFSET_X
		end
		if y + tooltipHeight > maxY then
			y = mousePos.Y - rootAbs.Y - tooltipHeight - TOOLTIP_OFFSET_Y
		end

		tooltipPosition = UDim2.fromOffset(x, y)
	end

	local children = if typeof(props.children) == "table"
		then table.clone(props.children :: { [any]: React.ReactNode })
		else {}

	children.Tooltip = if hovered and not props.Disabled and props.Text ~= ""
		then React.createElement("Frame", {
		ZIndex = props.TooltipZIndex or 999,
		Position = tooltipPosition,
		Size = UDim2.fromOffset(tooltipWidth, tooltipHeight),
		BackgroundTransparency = 1,
	}, {
		Shadow = React.createElement("Frame", {
			ZIndex = -1,
			Size = UDim2.new(1, SHADOW_OFFSET, 1, SHADOW_OFFSET),
			Position = UDim2.fromOffset(SHADOW_OFFSET, SHADOW_OFFSET),
			BackgroundColor3 = theme:GetColor(Enum.StudioStyleGuideColor.DropShadow, modifier),
			BorderSizePixel = 0,
		}),
		Body = React.createElement("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = theme:GetColor(Enum.StudioStyleGuideColor.MainBackground, modifier),
			BorderColor3 = theme:GetColor(Enum.StudioStyleGuideColor.Border, modifier),
		}, {
			Padding = React.createElement("UIPadding", {
				PaddingLeft = UDim.new(0, TOOLTIP_PADDING_X),
				PaddingRight = UDim.new(0, TOOLTIP_PADDING_X),
				PaddingTop = UDim.new(0, TOOLTIP_PADDING_Y),
				PaddingBottom = UDim.new(0, TOOLTIP_PADDING_Y),
			}),
			TextLabel = React.createElement("TextLabel", {
				BackgroundTransparency = 1,
				Font = Constants.DefaultFont,
				TextSize = Constants.DefaultTextSize,
				Text = props.Text,
				TextColor3 = theme:GetColor(Enum.StudioStyleGuideColor.MainText, modifier),
				Size = UDim2.fromScale(1, 1),
			}),
		}),
	})
	else nil

	return React.createElement("Frame", {
		ref = rootRef,
		Size = props.Size or UDim2.fromScale(1, 1),
		Position = props.Position,
		AnchorPoint = props.AnchorPoint,
		LayoutOrder = props.LayoutOrder,
		ZIndex = props.ZIndex,
		BackgroundTransparency = 1,
		[React.Event.InputBegan] = inputBegan,
		[React.Event.InputEnded] = inputEnded,
		[React.Event.InputChanged] = inputChanged,
	}, children)
end

return Tooltip
