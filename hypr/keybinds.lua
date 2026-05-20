-- windows key as main modifier
local main = "SUPER"

local scriptsDir = "$HOME/.config/hypr/scripts"
-- exec shortener
local exec = function(cmd)
	hl.dsp.exec_cmd(cmd)
end
-- noctalia-shell ipc call function
local noctaliaIpc = function(cmd)
	return hl.dsp.exec_cmd("qs -c noctalia-shell ipc call " .. cmd)
end
local ipc = "qs -c noctalia-shell ipc call"

local terminal = "kitty"
local fileManager = "thunar"
local menu = ipc .. " launcher toggle"

-- main utility binds, see https://wiki.hypr.land/Configuring/Binds/ for more
hl.bind(main .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(main .. " + Q", hl.dsp.window.close())
hl.bind(main .. " + P", noctaliaIpc("lockScreen lock"))
hl.bind(main .. " + M", noctaliaIpc("sessionMenu toggle"))
hl.bind(main .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(main .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main .. " + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" }))
hl.bind(main .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "maximized" }))
hl.bind(main .. " + D", noctaliaIpc("launcher toggle"))
-- toggle between dwindle and scrolling layout
hl.bind(main .. " + X", function()
	local layoutState = hl.get_config("general.layout")
	if layoutState == "dwindle" then
		hl.config({
			general = { layout = "scrolling" },
		})
	else
		hl.config({
			general = { layout = "dwindle" },
		})
	end
end)

-- noctalia shell specifics
-- -- network panel
hl.bind(main .. " +  F3", noctaliaIpc("network togglePanel"))
-- -- volume panel
hl.bind(main .. " +  F4", noctaliaIpc("volume togglePanel"))
-- -- media panel
hl.bind(main .. " +  F5", noctaliaIpc("media toggle"))

-- CUSTOM FEATURES
------------------
-- select emoji to clipboard
hl.bind(main .. " +  period", hl.dsp.exec_cmd(scriptsDir .. "/rofi-emoji-selector.sh"))
-- krunner style internet search with prefix:
-- hl.bind(ALT, F2, exec, $scriptsDir/rofi-krunner-search.sh)
-- screenshotting an area
hl.bind(
	"Print",
	hl.dsp.exec_cmd(
		'REGION=$(slurp) || exit; grim -g "$REGION" - | wl-copy &&  wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png && notify-send "Screenshot-$(date +%F_%T).png " -t 4000 --icon accessories-screenshot'
	)
)
-- screenshotting an entire screen
hl.bind(
	"SHIFT + Print",
	hl.dsp.exec_cmd(
		'grim - | wl-copy && wl-paste > ~/Pictures/screenshots/Screenshot-$(date +%F_%T).png && notify-send "Screenshot-$(date +%F_%T).png" -t 4000 --icon accessories-screenshot'
	)
)

-- MOVING FOCUS AND WINDOWS
---------------------------
-- helper function for binding an action in all for directions to arrows and hjkl
function bindArrowsHjkl(keysprefix, dispfunc)
	hl.bind(keysprefix .. " + left", dispfunc("left"))
	hl.bind(keysprefix .. " + down", dispfunc("down"))
	hl.bind(keysprefix .. " + up", dispfunc("up"))
	hl.bind(keysprefix .. " + right", dispfunc("right"))
	hl.bind(keysprefix .. " + H", dispfunc("left"))
	hl.bind(keysprefix .. " + J", dispfunc("down"))
	hl.bind(keysprefix .. " + K", dispfunc("up"))
	hl.bind(keysprefix .. " + L", dispfunc("right"))
end

-- move focus in direction
bindArrowsHjkl(main, function(dir)
	return hl.dsp.focus({ direction = dir })
end)

-- move window in direction, non-group-aware
bindArrowsHjkl(main .. " + SHIFT", function(dir)
	return hl.dsp.window.move({ direction = dir })
end)
-- move window in a direction into a group, or create a group if none exists
bindArrowsHjkl(main .. " + CONTROL", function(dir)
	return hl.dsp.window.move({ into_or_create_group = dir })
end)

-- toggle group state for active window
hl.bind(main .. " + G", hl.dsp.group.toggle({ window = "activewindow" }))
-- move window out of group, directionless
hl.bind(main .. " + SHIFT + G", hl.dsp.window.move({ out_of_group = true }))

-- swap active window with another one in direction
bindArrowsHjkl(main .. " + CONTROL + SHIFT", function(dir)
	return hl.dsp.window.swap({ direction = dir })
end)
-- swap active window with next/previous window)
hl.bind(main .. " + N", hl.dsp.window.swap({ next = true })) -- (N)ext
hl.bind(main .. " + B", hl.dsp.window.swap({ prev = true })) -- (B)efore

-- FOR SCROLLING LAYOUT
-----------------------
-- swap current column with the left/right neighbor
hl.bind(main .. " + I", hl.dsp.layout("swapcol l"))
hl.bind(main .. " + O", hl.dsp.layout("swapcol r"))
-- expel the window in the direction of not alone, moves it into the column in direction if alone
hl.bind(main .. " + Z", hl.dsp.layout("consume_or_expel prev"))
hl.bind(main .. " + U", hl.dsp.layout("consume_or_expel next"))

-- MOVE WORKSPACES AND WINDOWS BETWEEN WORKSPACES
-------------------------------------------------
-- Switch workspaces with main + [0-9]
-- Move active window to a workspace with main + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- map 10 to key 0
	hl.bind(main .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(main .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- move workspaces between monitors
hl.bind(main .. " + ALT + H", hl.dsp.workspace.move({ monitor = "left" }))
hl.bind(main .. " + ALT + L", hl.dsp.workspace.move({ monitor = "right" }))

-- define special scratchpad workspace
hl.bind(main .. " + minus", hl.dsp.workspace.toggle_special("magic"))
hl.bind(main .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with main + scroll
hl.bind(main .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- RESIZE WINDOWS
-----------------
-- Move/resize windows with main + LMB/RMB and dragging
hl.bind(main .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- start resize mode submap
hl.bind(main .. " + R", hl.dsp.submap("resize"))
-- define submap "resize"
hl.define_submap("resize", function()
	-- repeating binds using arrows & hjkl to resize the active window
	hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("h", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("j", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("k", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("l", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	-- use "escape" to end resize mode and return to global submap
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("return", hl.dsp.submap("reset"))
end)
-- end submap definition

-- VOLUME & BRIGHTNESS & MEDIA KEYS
-----------------------------------
-- use e.g. wpctl set-volume/set-mute
-- use noctalia-shell for volume
hl.bind("XF86AudioRaiseVolume", noctaliaIpc("volume increase"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", noctaliaIpc("volume decrease"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", noctaliaIpc("volume muteOutput"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", noctaliaIpc("volume muteInput"), { locked = true, repeating = true })
-- BRIGHTNESS KEYS
-- use e.g. brightnessctl
-- use noctalia-shell for brightness
hl.bind("XF86MonBrightnessUp", noctaliaIpc("brightness increase"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", noctaliaIpc("brightness decrease"), { locked = true, repeating = true })
-- MEDIA KEYS
-- use e.g. playerctl next/play-pause/previous
-- use noctalia-shell for media keys
hl.bind("XF86AudioNext", noctaliaIpc("media next"), { locked = true })
hl.bind("XF86AudioPause", noctaliaIpc("media playPause"), { locked = true })
hl.bind("XF86AudioPlay", noctaliaIpc("media playPause"), { locked = true })
hl.bind("XF86AudioStop", noctaliaIpc("media playPause"), { locked = true })
hl.bind("XF86AudioPrev", noctaliaIpc("media previous"), { locked = true })
