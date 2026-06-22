hl.on("window.active", function(w)
	if w.title == "Genshin Impact" and string.match(w.class, "^steam_app_") then
		hl.config({
			input = {
				repeat_rate = -1,
				repeat_delay = -1,
			},
		})
		hl.notification.create({ text = "disabled key repeating for Genshin Impact", duration = 3000, icon = 1 })
	else
		hl.config({
			input = {
				repeat_rate = 25,
				repeat_delay = 600,
			},
		})
	end
end)
