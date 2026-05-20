hl.on("hyprland.start", function()
	-- idle lock manager
	hl.exec_cmd("hypridle")
	-- quickshell: noctalia-shell
	hl.exec_cmd("qs -c noctalia-shell")
	-- use kwallet for secrets
	hl.exec_cmd("/usr/lib/pam_kwallet_init")
	-- udiskie auto-mounting manager
	hl.exec_cmd("udiskie --automount --notify --tray")
	-- japanese input with fcitx5 and mozc
	hl.exec_cmd("fctix5")
	-- tray applet for network manager
	hl.exec_cmd("nm-online -q -s -x && nm-applet")
	-- start hyprdynamicmonitors (it's dead after reboot sometimes...?)
	hl.exec_cmd("systemctl --user start hyprdynamicmonitors.service")
end)
