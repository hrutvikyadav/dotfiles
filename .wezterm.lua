-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
--local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
--config.color_scheme = 'rose-pine'

--config.font = wezterm.font("FiraCode Nerd Font", {weight="Regular", stretch="Normal", style="Normal"})
--config.font = wezterm.font "FiraCode Nerd Font"
--= wezterm.font("Victor Mono", {weight="Regular", stretch="Normal", style="Normal"})
--config.font_size = 10.0
--config.window_background_opacity = 0.6

-- A helper function for my fallback fonts
local function font_with_fallback(name, params)
	local names = {
		name,
		"Victor Mono",
		"Fira Code",
		"FiraCode Nerd Font Mono",
		"Hack Nerd Font",
		"Fira Code Retina",
		"Source Code Pro",
		"JetBrains Mono",
	}
	return wezterm.font_with_fallback(names, params)
end

local config = {
	font = font_with_fallback("FiraCode Nerd Font"),
	font_rules = {
		{
			italic = true,
			bold = true,
			intensity = "Bold",
			font = font_with_fallback("FiraCode Nerd Font", { italic = true, bold = true }),
		},
		{
			bold = true,
			intensity = "Bold",
			font = font_with_fallback("FiraCode Nerd Font", { bold = true }),
		},
		{
			italic = true,
			font = font_with_fallback("Victor Mono", { italic = true, bold = true }), -- {weight="Bold", stretch="Normal", style="Italic"}
		},
	},
	font_size = 11,
	line_height = 1.0,

	bold_brightens_ansi_colors = true,
	inactive_pane_hsb = { hue = 1.0, saturation = 0.7, brightness = 0.8 },
	color_scheme = "rose-pine",
	--launch_menu = { { args = { "btm" } } },
	--keys = mykeys,

	window_background_opacity = 0.83,
	-- win32_system_backdrop = "Acrylic", -- reference: https://wezfurlong.org/wezterm/config/lua/config/win32_system_backdrop.html#acrylic
	--window_background_opacity = 0.70,
	text_background_opacity = 1.0,
	hide_tab_bar_if_only_one_tab = true,
	exit_behavior = "Close",
}

config.default_prog = { "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" }
--[[
config.window_background_gradient = {
   colors = {
     --'#0f0c29',
     --'#302b63',
     --'#24243e',
     --'#42428a',
     --'#323267'
     --'#212145',
     --'#242442'
     --'#191934',
     '#29293d',
     '#262640'
   },

  --colors = {"deeppink", "gold"},
  -- alternative to colors
  --preset = "RdPu",
  --preset = "Warm",
  --preset = "Greys",
  -- Specifices a Linear gradient starting in the top left corner.
  orientation = { Linear = { angle = 180 } },

  --#region decent
  --colors = { '#EEBD89', '#D13ABD' },
  --orientation = {
  --      Radial = {
  --    -- Specifies the x coordinate of the center of the circle,
  --    -- in the range 0.0 through 1.0.  The default is 0.5 which
  --    -- is centered in the X dimension.
  --    cx = 0.75,

  --    -- Specifies the y coordinate of the center of the circle,
  --    -- in the range 0.0 through 1.0.  The default is 0.5 which
  --    -- is centered in the Y dimension.
  --    cy = 0.75,

  --    -- Specifies the radius of the notional circle.
  --    -- The default is 0.5, which combined with the default cx
  --    -- and cy values places the circle in the center of the
  --    -- window, with the edges touching the window edges.
  --    -- Values larger than 1 are possible.
  --    radius = 1.25,
  --  },
  --}
  --#endregion
}
]]
--

-- and finally, return the configuration to wezterm
return config
