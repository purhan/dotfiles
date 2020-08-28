local filesystem = require('gears.filesystem')
local mat_colors = require('theme.mat-colors')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local theme = {}
theme.icons = theme_dir .. '/icons/'
theme.font = 'Roboto medium 10'

-- Colors Pallets

-- Primary
theme.primary = mat_colors.deep_orange

-- Accent
theme.accent = mat_colors.orange

-- Background
theme.background = mat_colors.grey

local awesome_overrides =
  function(theme)
  theme.dir = os.getenv('HOME') .. '/.config/awesome/theme'

  theme.icons = theme.dir .. '/icons/'
  theme.font = 'Roboto medium 10'
  theme.title_font = 'Roboto medium 14'

  theme.fg_normal = '#ffffffde'

  theme.fg_focus = '#e4e4e4'
  theme.fg_urgent = '#CC9393'
  theme.bat_fg_critical = '#232323'

  theme.bg_normal = theme.primary.hue_900
  theme.bg_focus = '#5a5a5a'
  theme.bg_urgent = '#3F3F3F'
  theme.bg_systray = theme.primary.hue_900

  -- Borders

  theme.border_width = dpi(1)
  theme.border_normal = theme.primary.hue_900
  theme.border_focus = theme.primary.hue_500
  theme.border_marked = '#CC9393'

  -- Menu

  theme.menu_height = dpi(16)
  theme.menu_width = dpi(160)

  -- Tooltips
  theme.tooltip_bg = '#232323'
  --theme.tooltip_border_color = '#232323'
  theme.tooltip_border_width = 0
  theme.tooltip_shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(6))
  end

  -- Layout

  theme.layout_max = theme.icons .. 'layouts/arrow-expand-all.png'
  theme.layout_tile = theme.icons .. 'layouts/view-quilt.png'
  theme.layout_floating = theme.icons .. 'layouts/floating.png'

  -- Taglist

  theme.taglist_bg_empty = theme.primary.hue_900
  theme.taglist_bg_occupied = theme.primary.hue_900
  theme.taglist_bg_urgent =
    'linear:0,0:0,' ..
    dpi(48) ..
      ':0,' ..
        theme.accent.hue_500 ..
          ':0.07,' .. theme.accent.hue_500 .. ':0.07,' .. theme.primary.hue_900 .. ':1,' .. theme.primary.hue_900
  theme.taglist_bg_focus =
    'linear:0,0:0,' ..
    dpi(32) ..
      ':0,' ..
        theme.primary.hue_900 ..
          ':0.9,' .. theme.primary.hue_900 .. ':0.9,' .. theme.primary.hue_500 .. ':1,' .. theme.primary.hue_500

  -- Tasklist

  theme.tasklist_font = 'Roboto medium 11'
  theme.tasklist_bg_normal = theme.primary.hue_900
  theme.tasklist_bg_focus =
    'linear:0,0:0,' ..
    dpi(32) ..
      ':0,' ..
        theme.primary.hue_900 ..
          ':0.9,' .. theme.primary.hue_900 .. ':0.9,' .. theme.fg_normal .. ':1,' .. theme.fg_normal
  theme.tasklist_bg_urgent = theme.primary.hue_900
  theme.tasklist_fg_focus = '#DDDDDD'
  theme.tasklist_fg_urgent = theme.fg_normal
  theme.tasklist_fg_normal = '#AAAAAA'

  theme.icon_theme = 'Papirus-Dark'

  --Client
  theme.border_width = dpi(1)
  theme.border_focus = theme.primary.hue_500
  theme.border_normal = theme.primary.hue_900
end
return {
  theme = theme,
  awesome_overrides = awesome_overrides
}
