-- Pull in the wezterm API
local wezterm = require 'wezterm'

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

    -- window_background_opacity = 0.85,
    window_background_opacity = 0.70,
    text_background_opacity = 1.0,
    hide_tab_bar_if_only_one_tab = true,
    exit_behavior = "Close",
}

-- config.window_background_gradient = {
--   colors = {
--     '#0f0c29',
--     '#302b63',
--     '#24243e',
--   },
--   -- Specifices a Linear gradient starting in the top left corner.
--   orientation = { Linear = { angle = -45.0 } },
-- }



-- and finally, return the configuration to wezterm
return config
