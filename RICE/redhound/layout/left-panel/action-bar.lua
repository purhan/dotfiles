local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')
local mat_icon = require('widget.material.icon')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('theme.icons')
local TagList = require('widget.tag-list')
local clickable_container = require('widget.material.clickable-container')

return function(screen, panel, action_bar_width)
  local menu_icon =
    wibox.widget {
    icon = icons.menu,
    size = dpi(24),
    widget = mat_icon,
  }

  local home_button =
    wibox.widget {
    wibox.widget {
      menu_icon,
      widget = clickable_container
    },
    visible = true,
    bg = beautiful.primary.hue_500,
    widget = wibox.container.background
  }

  home_button:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          panel:toggle()
        end
      )
    )
  )

  panel:connect_signal(
    'opened',
    function()
      menu_icon.icon = icons.close
      home_button.visible = false
    end
  )

  panel:connect_signal(
    'closed',
    function()
      menu_icon.icon = icons.menu
      home_button.visible = true
    end
  )

  return wibox.widget {
    id = 'action_bar',
    layout = wibox.layout.align.horizontal,
    forced_width = action_bar_width,
    {
      layout = wibox.layout.fixed.horizontal,
      home_button,
    }
  }
end
