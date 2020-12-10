local filesystem = require('gears.filesystem')
local color_schemes = require('theme.color-schemes')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local theme = {}
theme.icons = theme_dir .. '/icons/'

-- Primary Color Scheme
theme.primary = color_schemes.dracula

local awesome_overrides = function(theme)
    theme.dir = os.getenv('HOME') .. '/.config/awesome/theme'

    theme.icons = theme.dir .. '/icons/'
    theme.wallpaper = theme.dir .. '/wallpapers/4.png' -- Can be replaced with a color (eg: '#e0e0e0')
    theme.font = 'FiraCode Nerd Font Mono bold 9'

    -- Layout
    theme.layout_max = theme.icons .. 'layouts/arrow-expand-all.png'
    theme.layout_tile = theme.icons .. 'layouts/view-quilt.png'
    theme.layout_floating = theme.icons .. 'layouts/floating.png'

    -- Taglist
    theme.taglist_font = theme.font
    theme.taglist_bg_empty = theme.primary.hue_900
    theme.taglist_bg_occupied = 'linear:0,0:0,' .. dpi(32) .. ':0,' .. theme.primary.hue_800 .. ':0.1,' ..
                                    theme.primary.hue_800 .. ':0.1,' .. theme.primary.hue_900 .. ':0.9,' ..
                                    theme.primary.hue_900
    theme.taglist_bg_urgent = 'linear:0,0:0,' .. dpi(48) .. ':0,' .. theme.primary.hue_700 .. ':0.07,' ..
                                  theme.primary.hue_700 .. ':0.07,' .. theme.primary.hue_900 .. ':1,' ..
                                  theme.primary.hue_900
    theme.taglist_bg_focus = theme.primary.hue_200
    theme.taglist_fg_focus = theme.primary.hue_900

    -- Tasklist
    theme.tasklist_font = theme.font
    theme.tasklist_bg_normal = theme.primary.hue_900
    theme.tasklist_bg_focus = theme.primary.hue_800
    theme.tasklist_bg_urgent = theme.primary.hue_900

    -- Icons
    theme.icon_theme = 'Papirus'

    -- Client
    theme.gaps = dpi(4)
    theme.border_width = dpi(2)
    theme.border_focus = theme.primary.hue_200
    theme.border_normal = theme.primary.hue_900
    theme.bg_normal = theme.primary.hue_900
    theme.bg_systray = theme.primary.hue_800
end
return {
    theme = theme,
    awesome_overrides = awesome_overrides
}
