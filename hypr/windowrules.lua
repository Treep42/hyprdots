-- ignore maximize requests from all apps
local suppressMaximizeRule = hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- avoid idle for fullscreen apps
hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { class = "^(.*)$" }, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { title = "^(.*)$" }, idle_inhibit = "fullscreen" })

-- applications/windows to set float and center for:
local floatCenterApps = {
	{ class = "^(pavucontrol|org.pulseaudio.pavucontrol)$" },
	{ class = "^(org.keepassxc.KeePassXC)$" },
	{ class = "([Dd]olphin)" },
	{ class = "([Tt]hunar)" },
	{ class = "(nm-applet)" },
	{ class = "(nm-connection-editor)" },
	{ class = "(blueman-manager)" },
	{ class = "(nwg-displays)" },
}

for _, appmatch in ipairs(floatCenterApps) do
	hl.window_rule({
		match = appmatch,
		float = true,
		center = true,
		size = { "(monitor_w*0.5)", "(monitor_h*0.5)" },
	})
end

-- applications/windows to set floating for:
local floatApps = {
	{ class = "^(org.fcitx.fcitx5-config-qt)$" },
	{ class = "^(.*)(org.fcitx.fcitx5-)(.*)$" },
	{ class = "^(org.kde.polkit-kde-authentication-agent-1)$" },
	{ class = "([Zz]oom|onedriver|onedriver-launcher)$" },
	{ class = "^(xdg-desktop-portal-gtk)$" },
	{ class = "^(nwg-look)$" },
	{ class = "^(qt5ct|qt6ct)$" },
	{ class = "^(mpv)$" },
	{ class = "([Ww]ebex)" },
	{ class = "^([Ss]team)$", title = "negative:^([Ss]team)$" },
	{ class = "^()$" },
}

for _, appmatch in ipairs(floatApps) do
	hl.window_rule({
		match = appmatch,
		float = true,
	})
end

-- move certain apps to specific workspaces
hl.window_rule({ match = { class = "^([Ss]team)$" }, workspace = 6 })
hl.window_rule({ match = { class = "^([Ff]erdium)$" }, workspace = 1 })
hl.window_rule({ match = { class = "^([Dd]iscord)$" }, workspace = 1 })
hl.window_rule({ match = { class = "^(org.keepassxc.KeePassXC)$" }, workspace = "special:magic" })
