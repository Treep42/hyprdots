-- setup cursor theme
local cursor = "catppuccin-frappe-green-cursors"
local cursorSize = 34
hl.env("XCURSOR_THEME", cursor)
hl.env("XCURSOR_SIZE", cursorSize)
hl.env("HYPRCURSOR_THEME", cursor)
hl.env("HYPRCURSOR_SIZE", cursorSize)

-- make sure kwallet is used for ssh passwords
hl.env("SSH_ASKPASS", "/usr/bin/ksshaskpass")
hl.env("SSH_ASKPASS_REQUIRE", "prefer")

-- use fcitx as input module
hl.env("QT_IM_MODULE", "fcitx5")
hl.env("XMODIFIERS", "@im=fcitx5")

-- enable qt6 theme (?)
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
