# Changelog

## 1.0.0

First release of StudioCreator after migration from [StudioComponents](https://github.com/sircfenner/StudioComponents).

### Added

- **Tooltip component** — Wraps any target element and displays a theme-aware tooltip at the bottom-right of the cursor on hover, with drop shadow, `TooltipZIndex` prop, and automatic screen-edge clamping
- **Switch component** — A toggle switch for enabling or disabling settings, with label support, hover/disabled states, and theme-aware colors matching the Checkbox/RadioButton style
- **`DisplayTitle` prop on TabContainer tabs** — Allows displaying custom text on tab buttons (e.g. `"Comments (3)"`), defaulting to the tab key if not provided

### Changed

- **Project renamed** from StudioComponents to StudioCreator across all source files, documentation, and configuration
- **Repository moved** to [Echo-Innovations/StudioCreator](https://github.com/Echo-Innovations/StudioCreator)
- **Package renamed** from `@sircfenner/studiocomponents` to `@echo-innovations/studiocreator`
- **Version reset** to 1.0.0 for the new project identity
- **README rewritten** with full API reference documenting all 22 components, CommonProps, Constants, contexts, hooks, why section, and migration guide
- **Documentation consolidated** — all docs moved into a single README.md
