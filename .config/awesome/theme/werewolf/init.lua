local filesystem = require('gears.filesystem')
local mat_colors = require('theme.mat-colors')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local dpi = require('beautiful').xresources.apply_dpi

local theme = {}
theme.icons = theme_dir .. '/icons/'
theme.font = 'Roboto medium 10'

-- Colors Pallets

-- Primary
theme.primary = mat_colors.grey
theme.primary.hue_200 = '#50fa7b'
theme.primary.hue_300 = '#f8f8f2'
theme.primary.hue_350 = '#ff5555'
theme.primary.hue_400 = '#ffb86c'
theme.primary.hue_500 = '#6272a4'
theme.primary.hue_600 = '#ff79c6'
theme.primary.hue_700 = '#bd93f9'
theme.primary.hue_800 = '#44475a'
theme.primary.hue_900 = '#282a36'
-- theme.primary = mat_colors.indigo
-- Accent
theme.accent = mat_colors.orange

-- Background
theme.background = mat_colors.blue_grey

theme.background.hue_800 = '#44475a'
theme.background.hue_900 = '#44475a'

local awesome_overrides = function(theme)
    --
end
return {theme = theme, awesome_overrides = awesome_overrides}
