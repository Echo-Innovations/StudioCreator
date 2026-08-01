local React = require("@pkg/@jsdotlua/react")

local Switch = require("../Components/Switch")
local createStory = require("./Helpers/createStory")

local function StoryItem(props: {
	LayoutOrder: number,
	Value: boolean?,
	Label: string,
})
	return React.createElement("Frame", {
		Size = UDim2.new(0, 200, 0, 50),
		BackgroundTransparency = 1,
		LayoutOrder = props.LayoutOrder,
	}, {
		Layout = React.createElement("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 2),
			VerticalAlignment = Enum.VerticalAlignment.Center,
		}),
		Enabled = React.createElement(Switch, {
			Label = props.Label,
			Value = props.Value,
			OnChanged = function() end,
			LayoutOrder = 1,
		}),
		Disabled = React.createElement(Switch, {
			Label = `{props.Label} (Disabled)`,
			Value = props.Value,
			OnChanged = function() end,
			Disabled = true,
			LayoutOrder = 2,
		}),
	})
end

local function Story()
	local value, setValue = React.useState(true)

	return React.createElement(React.Fragment, {}, {
		Interactive = React.createElement(Switch, {
			Size = UDim2.fromOffset(200, 20),
			Label = "Interactive (try me)",
			Value = value,
			OnChanged = function()
				setValue(not value)
			end,
			LayoutOrder = 1,
		}),

		On = React.createElement(StoryItem, {
			Label = "On",
			Value = true,
			LayoutOrder = 2,
		}),

		Off = React.createElement(StoryItem, {
			Label = "Off",
			Value = false,
			LayoutOrder = 3,
		}),
	})
end

return createStory(Story)
