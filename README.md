<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/badge/Version-1.0.0-blueviolet?style=flat-square">
    <img src="https://img.shields.io/badge/Version-1.0.0-blueviolet?style=flat-square"/>
  </picture>
  <img src="https://img.shields.io/badge/language-Luau-00A2FF?style=flat-square&logo=lua"/>
</p>

<h1 align="center">StudioCreator</h1>
<p align="center">
  <em>React components for building Roblox Studio plugins.</em>
  <br>
</p>

> This project is a continuation and updated version of [StudioComponents](https://github.com/sircfenner/StudioComponents) by [sircfenner](https://github.com/sircfenner), the original creator.

---

## Table of Contents

- [Overview](#overview)
- [Why StudioCreator?](#why-studiocreator)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [CommonProps](#commonprops)
- [Constants](#constants)
- [Components](#components)
  - [Background](#background)
  - [Button](#button)
  - [Checkbox](#checkbox)
  - [ColorPicker](#colorpicker)
  - [DatePicker](#datepicker)
  - [Dropdown](#dropdown)
  - [DropShadowFrame](#dropshadowframe)
  - [Label](#label)
  - [LoadingDots](#loadingdots)
  - [MainButton](#mainbutton)
  - [NumberSequencePicker](#numbersequencepicker)
  - [NumericInput](#numericinput)
  - [PluginProvider](#pluginprovider)
  - [ProgressBar](#progressbar)
  - [RadioButton](#radiobutton)
  - [ScrollFrame](#scrollframe)
  - [Slider](#slider)
  - [Splitter](#splitter)
  - [Switch](#switch)
  - [TabContainer](#tabcontainer)
  - [TextInput](#textinput)
  - [Tooltip](#tooltip)
- [Contexts](#contexts)
  - [ThemeContext](#themecontext)
  - [PluginContext](#plugincontext)
- [Hooks](#hooks)
  - [useTheme](#usetheme)
  - [usePlugin](#useplugin)
  - [useMouseIcon](#usemouseicon)
- [Scripts](#scripts)
- [License](#license)

---

## Overview

A collection of recreated built-in Studio UI elements - Checkboxes, Buttons, Dropdowns, Toggle Switches, and more - that match the look, feel, and theme responsiveness of native Studio widgets.

Built for [react-lua](https://github.com/jsdotlua/react-lua), the Roblox translation of React 17.x into Luau.

> [!NOTE]
> These components are only suitable for use in plugins. They rely on plugin- or Studio-only APIs.

---

## Why StudioCreator?

Closely replicating the built-in Studio UI has two main advantages:

1. Roblox Studio users recognise these components and know how to use them.
2. Less adjustment required when switching between third-party and built-in interfaces.

With wider adoption, using these components to build a plugin aligns it with other third-party plugins in appearance, familiarity, and usability. Many plugins have been built with this component set, including Archimedes 3, Collision Groups Editor, Benchmarker, and LampLight.

---

## Prerequisites

- [Node.js](https://nodejs.org/) (for npm)
- [Rokit](https://github.com/rojo-rbx/rokit) (for toolchain: Rojo, Darklua, StyLua, Selene, Wally)
- [Roblox Studio](https://create.roblox.com/)
- [Git Bash](https://git-scm.com/) (or any Unix-compatible shell for running scripts)

---

## Installation

```bash
# 1. Clone the repository
git clone https://github.com/Echo-Innovations/StudioCreator.git
cd StudioCreator

# 2. Install npm dependencies
npm i

# 3. Generate Luau type aliases
npx npmluau

# 4. Install toolchain (Rojo, Darklua, StyLua, etc.)
rokit install

# 5. Install the Rojo Studio plugin
rojo plugin install
```

---

## Usage

### Serving in Studio

From a Git Bash terminal in the project root:

```bash
npm run serve
```

This starts file watchers (Rojo sourcemap + Darklua) and runs `rojo serve`. Connect from Roblox Studio via the Rojo plugin to see the component library running live.

### Using in your own plugin

**Wally:**

```toml
studiocreator = "echo-innovations/studiocreator@1.0.0"
```

**NPM:**

```bash
npm install @echo-innovations/studiocreator
```

**Yarn:**

```bash
yarn add @echo-innovations/studiocreator
```

Then in your Luau code:

```lua
local React = require(Packages.React)
local StudioCreator = require(Packages.StudioCreator)

local function MyPlugin()
    return React.createElement(StudioCreator.Label, {
        Text = "Hello, from StudioCreator!",
    })
end
```

---

## CommonProps

Props accepted by every component (unless explicitly noted). These are inherited by all components and are **not** re-listed in each component's table below.

| Prop | Type | Description |
|------|------|-------------|
| Disabled | `boolean?` | Disable the component, graying it out and preventing interaction |
| AnchorPoint | `Vector2?` | The anchor point for positioning |
| Position | `UDim2?` | The position of the component |
| Size | `UDim2?` | The size of the component (defaults vary per component) |
| LayoutOrder | `number?` | Layout order for UIListLayout/UIGridLayout parents |
| ZIndex | `number?` | The Z-index/layer ordering |

---

## Constants

A read-only table of default sizing values used by components. These can be used to match the appearance of custom components with library components.

| Constant | Type | Value | Description |
|----------|------|-------|-------------|
| DefaultFont | `Font` | `Enum.Font.SourceSans` | The default font for text |
| DefaultTextSize | `number` | `14` | The default size for text |
| DefaultButtonHeight | `number` | `24` | The default height of buttons |
| DefaultToggleHeight | `number` | `20` | The default height of toggles (Checkbox, RadioButton, Switch) |
| DefaultInputHeight | `number` | `22` | The default height of text and numeric inputs |
| DefaultSliderHeight | `number` | `22` | The default height of sliders |
| DefaultDropdownHeight | `number` | `20` | The default height of the dropdown toggle |
| DefaultDropdownRowHeight | `number` | `16` | The default height of rows in dropdown lists |
| DefaultProgressBarHeight | `number` | `14` | The default height of progress bars |
| DefaultColorPickerSize | `UDim2` | `(260, 285)` | The default window size of color pickers |
| DefaultNumberSequencePickerSize | `UDim2` | `(425, 285)` | The default window size of number sequence pickers |
| DefaultDatePickerSize | `UDim2` | `(202, 160)` | The default window size of date pickers |

---

## Components

### Background

A borderless frame matching the default background color of Studio widgets. Any children passed will be parented to the frame, making it suitable as the root component in a plugin Widget.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| children | `React.ReactNode` | Children to render inside the background frame |

---

### Button

A basic button that supports text, an icon, or both. Use as a standalone button or as a secondary button alongside a MainButton for the primary action.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| AutomaticSize | `AutomaticSize?` | Simplified automatic sizing; overrides width/height to fit text and/or icon |
| OnActivated | `(() -> ())?` | Callback when the button is clicked |
| Text | `string?` | The text displayed on the button |
| Icon | `IconProps?` | Icon configuration (see below) |

**IconProps** (shared by Button, MainButton, and Dropdown):

| Prop | Type | Description |
|------|------|-------------|
| Image | `string` | The asset ID or URL of the icon image |
| Size | `Vector2` | The render size of the icon |
| Transparency | `number?` | Icon transparency |
| Color | `Color3?` | Icon tint color (mutually exclusive with UseThemeColor) |
| UseThemeColor | `boolean?` | Whether to use the theme color for the icon |
| Alignment | `HorizontalAlignment?` | Which side of any text the icon appears on (default: Left; Center not supported) |
| ResampleMode | `Enum.ResamplerMode?` | The resampling mode for the icon |
| RectOffset | `Vector2?` | Offset into the image for the displayed region |
| RectSize | `Vector2?` | Size of the displayed region within the image |

---

### Checkbox

A box which can be checked or unchecked, usually used to toggle an option. Passing a value to the `Label` prop is the recommended way to indicate the purpose of a checkbox. Can also represent indeterminate values by passing `nil` to `Value`.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| Value | `boolean?` | Whether the checkbox is checked (`true`), unchecked (`false`), or indeterminate (`nil`) |
| OnChanged | `(() -> ())?` | Callback when the user interacts with the checkbox |
| Label | `string?` | Descriptive text next to the checkbox |
| ContentAlignment | `HorizontalAlignment?` | Horizontal alignment of the whole checkbox within its parent frame |
| ButtonAlignment | `HorizontalAlignment?` | Whether the box is placed to the left or right of the label |

---

### ColorPicker

An interface for selecting a color with a Hue/Saturation box and a Value slider. Individual RGB and HSV values can also be modified manually. This is not a modal - that must be implemented separately.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| Color | `Color3` | The current selected color |
| OnChanged | `((newColor: Color3) -> ())?` | Callback when the user changes the color |

---

### DatePicker

An interface for selecting a date from a calendar.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| Date | `DateTime` | The current selected date |
| OnChanged | `((newDate: DateTime) -> ())?` | Callback when the user selects a new date |

---

### Dropdown

A togglable popup box containing a list of items to select a single item from. Automatically opens upward if there is insufficient space below. The list closes when an item is selected, the user clicks elsewhere, or Escape is pressed. Manages its own open/closed state but is otherwise controlled.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| Items | `{ DropdownItem }` | The list of selectable items (strings or `DropdownItemDetail` objects) |
| OnItemSelected | `((newItem: string?) -> ())?` | Callback when an item is selected; called with the item's ID or `nil` if cleared |
| SelectedItem | `string?` | The currently selected item ID |
| DefaultText | `string?` | Placeholder text when no item is selected (defaults to "Select...") |
| RowHeight | `number?` | Height of each row in the dropdown list (default: `Constants.DefaultDropdownRowHeight`) |
| MaxVisibleRows | `number?` | Maximum number of rows visible before scrolling (default: 8) |
| ClearButton | `boolean?` | If `true`, shows a button to clear the selected value |

**DropdownItemDetail** interface (for Items array entries):

| Prop | Type | Description |
|------|------|-------------|
| Id | `string` | Unique identifier for the item |
| Text | `string` | Display text for the item |
| Icon | `IconProps?` | Optional icon for the item (same as Button's IconProps) |

---

### DropShadowFrame

A container frame equivalent in appearance to a Background but with a drop shadow on the lower right sides and corner. Useful for providing contrast against a background.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| children | `React.ReactNode` | Children to render inside the container frame |

---

### Label

A basic text label with default styling to match built-in labels as closely as possible. By default, text color matches the current theme's MainText color. Supports theming via `TextColorStyle` or arbitrary colors via `TextColor3`.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| Text | `string` | The text to display |
| TextWrapped | `boolean?` | Whether text wraps to the next line |
| TextXAlignment | `Enum.TextXAlignment?` | Horizontal text alignment |
| TextYAlignment | `Enum.TextYAlignment?` | Vertical text alignment |
| TextTruncate | `Enum.TextTruncate?` | Text truncation mode |
| TextTransparency | `number?` | Text transparency |
| TextColor3 | `Color3?` | Explicit text color (overrides theme) |
| RichText | `boolean?` | Whether rich text formatting is enabled |
| MaxVisibleGraphemes | `number?` | Maximum number of visible graphemes |
| TextColorStyle | `Enum.StudioStyleGuideColor?` | Theme color style for the text (defaults to `MainText`) |
| children | `React.ReactNode` | Children rendered inside the TextLabel (e.g. UIPadding, UIStroke) |

---

### LoadingDots

A basic animated loading indicator that matches similar indicators used around Studio. Use for short processes where the user does not need to see detailed progress. For longer loading, use ProgressBar.

**Props:** Only CommonProps (no additional props).

---

### MainButton

A variant of Button used to indicate a primary action, such as an 'OK/Accept' button in a modal. Uses `DialogMainButton` styling.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| AutomaticSize | `AutomaticSize?` | Simplified automatic sizing |
| OnActivated | `(() -> ())?` | Callback when the button is clicked |
| Text | `string?` | The text displayed on the button |
| Icon | `IconProps?` | Icon configuration (same as Button's IconProps) |

---

### NumberSequencePicker

An interface for modifying NumberSequence values. Closely resembles the built-in NumberSequence picker with minor readability improvements.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| Value | `NumberSequence` | The current NumberSequence value |
| OnChanged | `((newValue: NumberSequence) -> ())?` | Callback when the user changes the sequence |

---

### NumericInput

An input field matching the appearance of TextInput but which filters input to only allow numeric values. Optionally includes arrow buttons and/or a slider control.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| Value | `number` | The current numeric value |
| OnValidChanged | `((n: number) -> ())?` | Callback when a valid numeric value is entered |
| Min | `number?` | Minimum allowed value |
| Max | `number?` | Maximum allowed value |
| Step | `number?` | Step increment (defaults to 1, allowing only whole numbers) |
| OnSubmitted | `((n: number) -> ())?` | Callback when input is submitted (Enter pressed or focus lost) or slider drag completes |
| FormatValue | `((n: number) -> string)?` | Custom formatter to convert the number to a display string |
| Arrows | `boolean?` | Whether to show up/down arrow buttons |
| Slider | `boolean?` | Whether to show a slider control |
| PlaceholderText | `string?` | Placeholder text when the input is empty |
| ClearTextOnFocus | `boolean?` | Whether to clear the text when the input gains focus |
| OnFocused | `(() -> ())?` | Callback when the input gains focus |
| OnFocusLost | `((text: string, enterPressed: boolean, input: InputObject) -> ())?` | Callback when the input loses focus |

---

### PluginProvider

Provides an interface to plugin APIs for other components in the tree. Required only if using custom mouse icons via the `useMouseIcon` hook; theming and all other functionality work without it. Only one should be rendered, typically at the top of the tree.

**Props:**

| Prop | Type | Description |
|------|------|-------------|
| Plugin | `Plugin` | The plugin's root instance (`plugin`) |
| children | `React.ReactNode` | Children to render within the provider |

---

### ProgressBar

A basic progress indicator for longer or more detailed loading processes. For shorter loads, consider LoadingDots. Supports custom text formatting.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| Value | `number` | Current progress value (should be between 0 and Max) |
| Max | `number?` | Maximum progress value (defaults to 1) |
| Formatter | `((value: number, max: number) -> string)?` | Custom formatter for the progress text (default: percentage rounded to nearest whole number) |

---

### RadioButton

An input element similar to Checkbox which can either be selected or not selected. Use for options in a mutually exclusive group (grouping behavior must be implemented separately).

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| Value | `boolean?` | Whether the radio button is selected |
| OnChanged | `(() -> ())?` | Callback when the user interacts with the radio button |
| Label | `string?` | Descriptive text next to the radio button |
| ContentAlignment | `HorizontalAlignment?` | Horizontal alignment of the whole component within its parent frame |
| ButtonAlignment | `HorizontalAlignment?` | Whether the button is placed to the left or right of the label |

---

### ScrollFrame

A container with scrollable contents. Works like a built-in ScrollingFrame but with visual changes to match Studio's built-in scrollers. Automatically sizes its canvas to fit contents.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| Layout | `{ ClassName: string, [string]: any }?` | Layout configuration; `ClassName` may be `"UIListLayout"` or `"UIGridLayout"` with optional native props (defaults to UIListLayout) |
| ScrollingDirection | `Enum.ScrollingDirection?` | Which axes scrolling is enabled on (default: both X and Y) |
| PaddingLeft | `UDim?` | Left padding around contents |
| PaddingRight | `UDim?` | Right padding around contents |
| PaddingTop | `UDim?` | Top padding around contents |
| PaddingBottom | `UDim?` | Bottom padding around contents |
| OnScrolled | `((scrollOffset: Vector2) -> ())?` | Callback when the scroll position changes |
| children | `React.ReactNode` | Children to render inside the scrollable area |

---

### Slider

A component for selecting a numeric value from a range with an optional step increment. Seen in number-valued properties in the built-in Properties widget and various built-in plugins.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| Value | `number` | The current slider value |
| OnChanged | `((newValue: number) -> ())?` | Callback as the user drags or clicks the slider |
| OnCompleted | `((newValue: number) -> ())?` | Callback when sliding is finished (also called if the component becomes disabled or unmounts during a slide) |
| Min | `number` | Minimum value of the slider range |
| Max | `number` | Maximum value of the slider range |
| Step | `number?` | Step increment (defaults to 0, allowing any value) |
| Border | `boolean?` | Whether a border is drawn around the component (defaults to `true`) |
| Background | `boolean?` | Whether the component has a visible background (defaults to `true`; if `false`, border is also hidden) |

---

### Splitter

A container frame split into two panels with a draggable control for resizing them. Resizing one panel affects the other. Can use system mouse icons when a PluginProvider is present.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| Alpha | `number` | Current split location as a number between 0 and 1 |
| OnChanged | `((newAlpha: number) -> ())?` | Callback when the user drags the splitter bar |
| FillDirection | `Enum.FillDirection?` | Split direction: `Horizontal` (left/right, default) or `Vertical` (top/bottom) |
| MinAlpha | `number?` | Minimum allowed alpha value (defaults to 0.1) |
| MaxAlpha | `number?` | Maximum allowed alpha value (defaults to 0.9) |
| children | `{ Side0: React.ReactNode, Side1: React.ReactNode }?` | Children rendered in each side panel, keyed by `Side0` and `Side1` |

---

### Switch

A toggle switch which can be turned on or off, usually used to enable or disable a setting. The `Label` prop should be used to indicate the purpose of the switch.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| Value | `boolean?` | Whether the switch is turned on |
| OnChanged | `(() -> ())?` | Callback when the user toggles the switch |
| Label | `string?` | Descriptive text next to the switch |

---

### TabContainer

A container that displays one content page at a time, where different pages are selected via tabs along the top. Seen in built-in plugins such as the Toolbox. Individual tabs can be independently disabled.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| SelectedTab | `string` | The identifier of the currently selected tab |
| OnTabSelected | `((name: string) -> ())?` | Callback when the user selects a tab |
| children | `{ [string]: Tab }?` | Tab entries keyed by identifier |

**Tab** interface (per-tab entry in `children`):

| Prop | Type | Description |
|------|------|-------------|
| LayoutOrder | `number` | The display order of the tab |
| DisplayTitle | `string?` | Custom text to show on the tab button (defaults to the tab key) |
| Content | `React.ReactNode` | Content rendered when this tab is selected |
| Disabled | `boolean?` | Whether this specific tab is disabled and unselectable |

---

### TextInput

A basic input field for entering any kind of text. Matches the appearance of search boxes in the Explorer and Properties widgets.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| Text | `string` | The current text in the input |
| OnChanged | `((newText: string) -> ())?` | Callback when the user types in the input field |
| PlaceholderText | `string?` | Placeholder text when the input is empty |
| ClearTextOnFocus | `boolean?` | Whether to clear the text when the input gains focus |
| OnFocused | `(() -> ())?` | Callback when the input gains focus |
| OnFocusLost | `((text: string, enterPressed: boolean, input: InputObject) -> ())?` | Callback when the input loses focus |

---

### Tooltip

Wraps a target element and displays a tooltip at the bottom-right of the cursor when the mouse hovers over it. The tooltip is styled to match built-in Studio tooltips with a drop shadow. It automatically clamps to stay within parent bounds and hides when the cursor leaves.

**Props** (in addition to CommonProps):

| Prop | Type | Description |
|------|------|-------------|
| Text | `string` | The text to display in the tooltip |
| TooltipZIndex | `number?` | Z-index of the tooltip overlay (defaults to 999) |
| children | `React.ReactNode` | The target element to wrap and hover over |

---

## Contexts

### ThemeContext

A React context that provides a `StudioTheme` instance to descendant components. Used internally by `useTheme` to read the current Studio theme.

---

### PluginContext

A React context that provides plugin API access to descendant components. Set up automatically by `PluginProvider`.

**PluginContext type:**

| Field | Type | Description |
|-------|------|-------------|
| plugin | `Plugin` | The plugin's root instance |
| pushMouseIcon | `(icon: string) -> string` | Push a mouse icon onto the stack, returning an ID for later removal |
| popMouseIcon | `(id: string) -> ()` | Remove a mouse icon from the stack by its ID |

---

## Hooks

### useTheme

A hook for reading the selected Studio Theme. Returns a `StudioTheme` instance that can be used to theme custom components. Falls back to `Studio.Theme` if no ThemeContext provider is present. **No provider required to function.**

**Returns:** `StudioTheme` - the current Studio theme instance.

---

### usePlugin

A hook that obtains a reference to the root `Plugin` instance associated with the current plugin. Requires a single `PluginProvider` to be present higher up in the tree.

**Returns:** `Plugin?` - the plugin's root instance, or `nil` if no PluginProvider is mounted.

---

### useMouseIcon

A hook for setting and clearing custom mouse icons. Requires a `PluginProvider` higher up in the tree. Multiple components can share an icon stack - the most recent call to `setIcon` wins.

**Returns:** `mouseIconApi` - an object with the following methods:

| Method | Signature | Description |
|--------|-----------|-------------|
| setIcon | `(icon: string) -> ()` | Sets the mouse icon to the given asset URL |
| getIcon | `() -> string?` | Returns the last icon URL set by this component |
| clearIcon | `() -> ()` | Removes this component's icon from the stack |

---

## Scripts

| Command | Description |
|---------|-------------|
| `npm run serve` | Build and serve the project in Studio |
| `npm run lint` | Run Luau linter and Selene |
| `npm run format` | Format all source files with StyLua |
| `npm run style-check` | Check formatting without applying |
| `npm run clean` | Remove build artifacts |

---

## License

MIT © Echo-Innovations
