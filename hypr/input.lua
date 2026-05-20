hl.config({
	input = {
		-- KEYBOARD
		kb_layout = "de",
		numlock_by_default = true,
		-- MOUSE
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification
		-- 0 : cursor movement won't change focus
		-- 1 : cursor movement will always change focus to window under cursor
		-- 2 : cursor focus will be detached from keyboard focus. clicking on a window will move keyboard focus to that window
		-- 3 : cursor focus will be completely separate from keyboard focus. clicking on a window will not change keyboard focus
		follow_mouse = 2,
		-- control window focus behaviour when a window is closed
		-- 0 : shift focus to next window candidate
		-- 1 : shift focus to window under cursor
		-- 2 : shift focus to most recently used/active window
		focus_on_close = 2,
		-- when enabled, having only floating windows in the special workspace will not block focusing windows in the regular workspace
		special_fallthrough = true,

		-- TOUCHPAD
		touchpad = {
			disable_while_typing = true,
			natural_scroll = false,
			-- sending LMB + RMB will be interpreted as middle click
			middle_button_emulation = true,
			-- tapping with 1, 2 or 3 fingers will send LMB, RMB, or MMB respectively
			tap_to_click = true,
			-- drag lock: when enabled, lifting the finger off while dragging will not drop the dragged item
			-- 0 : disabled; 1 : enabled with timeout; 2 : enabled sticky
			drag_lock = 1,
		},
	},
})

-- define touchpad gestures
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
