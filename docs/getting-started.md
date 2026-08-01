---
sidebar_position: 2
---

# Getting Started

This project is built for react-lua, which can be installed either via NPM/yarn, wally, or a release. See the [repository](https://github.com/jsdotlua/react-lua) for more information.

StudioCreator exposes a table of components, hooks, and a reference to the Constants file. Minimal example of using a component from StudioCreator:

```lua
local React = require(Packages.React)
local StudioCreator = require(Packages.StudioCreator)

local function MyComponent()
	return React.createElement(StudioCreator.Label, {
		Text = "Hello, from StudioCreator!"
	})
end
```

## Installation

### Wally

Add `studiocomponents` to your `wally.toml`:

```toml
studiocomponents = "sircfenner/studiocomponents@1.0.0"
```

### NPM & yarn

Add `studiocomponents` to your dependencies:

```bash
npm install @sircfenner/studiocomponents
```

```bash
yarn add @sircfenner/studiocomponents
```

Run `npmluau`.
