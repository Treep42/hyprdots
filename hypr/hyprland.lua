-- main hypr config file

-- import env first
-- ENVIRONMENT VARIABLES
require("env")

-- import colorscheme next, this sets various color variables
require("catppuccin-frappe")

-- AUTOSTART
require("autostart")

-- PERMISSIONS
require("permissions")

-- LOOK AND FEEL: DECORATION & ANIMATIONS & LAYOUT
require("look_and_feel")
require("layout")
require("layerrules")

-- INPUT: KEYBOARD & MOUSE SETTINGS
require("input")

-- KEYBINDS
require("keybinds")

-- WINDOWSRULES
require("windowrules")

-- MISC

hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		font_family = "Liberation Sans",
		splash_font_family = "Maple Mono",
	},
})

-- ensure xwayland windows don't try to scale weirdly on highdpi screens
hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

-- import monitros last to enable them to override previous settings (e.g. disable animations when on battery power)
-- MONITOR CONFIGURATION
require("monitor")
