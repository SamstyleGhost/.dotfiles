local wez = require("wezterm")

local M = {}

M.apply_to_config = function(c)
	c.color_scheme = "Azu (Gogh)"
	local scheme = wez.color.get_builtin_schemes()["Azu (Gogh)"]
	c.window_background_image = "/home/rohan/Pictures/wezterm_bg.jpg"
	c.colors = {
		split = scheme.ansi[2],
	}
	c.window_background_image_hsb = {
		brightness = 0.1,
	}
	c.window_padding = { left = "1cell", right = "1cell", top = 0, bottom = 0 }
	c.window_decorations = "RESIZE"
	c.show_new_tab_button_in_tab_bar = false
end

return M
