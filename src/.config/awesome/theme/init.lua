local gtable = require('gears.table')
local theme = require('theme.theme')

local final_theme = {}
gtable.crush(final_theme, theme.theme)
gtable.crush(final_theme, theme.theme)
theme.awesome_overrides(final_theme)
theme.awesome_overrides(final_theme)

return final_theme
