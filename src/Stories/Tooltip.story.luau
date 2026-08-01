local React = require("@pkg/@jsdotlua/react")

local Button = require("../Components/Button")
local MainButton = require("../Components/MainButton")
local Tooltip = require("../Components/Tooltip")
local createStory = require("./Helpers/createStory")

local TARGET_WIDTH = 160
local TARGET_HEIGHT = 24

local function Story()
	return React.createElement(React.Fragment, {}, {
		Spacer = React.createElement("Frame", {
			Size = UDim2.new(1, 0, 0, 20),
			BackgroundTransparency = 1,
			LayoutOrder = 1,
		}),
		ButtonRow = React.createElement("Frame", {
			Size = UDim2.new(1, 0, 0, TARGET_HEIGHT),
			BackgroundTransparency = 1,
			LayoutOrder = 2,
		}, {
			Layout = React.createElement("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 40),
				VerticalAlignment = Enum.VerticalAlignment.Center,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
			}),
			Accept = React.createElement(Tooltip, {
				Text = "Click to accept the changes",
				Size = UDim2.fromOffset(TARGET_WIDTH, TARGET_HEIGHT),
				LayoutOrder = 1,
			}, {
				React.createElement(MainButton, {
					Text = "Accept",
					Size = UDim2.fromScale(1, 1),
				}),
			}),
			Disabled = React.createElement(Tooltip, {
				Text = "This action is currently unavailable",
				Size = UDim2.fromOffset(TARGET_WIDTH, TARGET_HEIGHT),
				LayoutOrder = 2,
			}, {
				React.createElement(Button, {
					Text = "Disabled",
					Size = UDim2.fromScale(1, 1),
					Disabled = true,
				}),
			}),
		}),
		Spacer2 = React.createElement("Frame", {
			Size = UDim2.new(1, 0, 0, 40),
			BackgroundTransparency = 1,
			LayoutOrder = 3,
		}),
		SettingsRow = React.createElement("Frame", {
			Size = UDim2.new(1, 0, 0, TARGET_HEIGHT),
			BackgroundTransparency = 1,
			LayoutOrder = 4,
		}, {
			Layout = React.createElement("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 40),
				VerticalAlignment = Enum.VerticalAlignment.Center,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
			}),
			Shadows = React.createElement(Tooltip, {
				Text = "Controls how shadows are rendered across all viewports",
				Size = UDim2.fromOffset(TARGET_WIDTH, TARGET_HEIGHT),
				LayoutOrder = 1,
			}, {
				React.createElement(Button, {
					Text = "Shadow Settings",
					Size = UDim2.fromScale(1, 1),
				}),
			}),
			Grid = React.createElement(Tooltip, {
				Text = "Hold Ctrl and drag to snap to grid",
				Size = UDim2.fromOffset(TARGET_WIDTH, TARGET_HEIGHT),
				LayoutOrder = 2,
			}, {
				React.createElement(Button, {
					Text = "Snap to Grid",
					Size = UDim2.fromScale(1, 1),
				}),
			}),
		}),
	})
end

return createStory(Story)
