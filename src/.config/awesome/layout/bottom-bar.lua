local beautiful = require('beautiful')
local wibox = require('wibox')
local TaskList = require('widget.task-list')
local dpi = require('beautiful').xresources.apply_dpi

local BottomBar = function(s, offset)

    -- BOTTOM BAR
    -- =======
    local panel_height = dpi(16)
    local panel = wibox({
        ontop = false,
        screen = s,
        height = panel_height,
        width = s.geometry.width,
        x = s.geometry.x,
        y = s.geometry.height - panel_height,
        stretch = false,
        bg = beautiful.primary.hue_100,
        fg = beautiful.fg_normal,
    })

    panel:struts({
        bottom = panel.height
    })

    panel:setup{
        layout = wibox.layout.align.horizontal,
        nil,
        TaskList(s),
        nil,
    }

    return panel
end

return BottomBar
