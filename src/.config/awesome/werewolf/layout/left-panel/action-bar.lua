local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')
local mat_icon = require('widget.material.icon')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('theme.icons')
local clickable_container = require('widget.material.clickable-container')

return function(screen, panel, action_bar_width)
    local menu_icon = wibox.widget {
        icon = icons.menu,
        size = dpi(16),
        widget = mat_icon
    }

    local home_button = wibox.widget {
        wibox.widget {menu_icon, widget = clickable_container},
        visible = true,
        bg = beautiful.primary.hue_700,
        widget = wibox.container.background
    }

    home_button:buttons(gears.table.join(
                            awful.button({}, 1, nil,
                                         function() _G.dashboard_show() end)))

    return wibox.widget {
        id = 'action_bar',
        layout = wibox.layout.align.horizontal,
        forced_width = action_bar_width,
        {layout = wibox.layout.fixed.horizontal, home_button}
    }
end
