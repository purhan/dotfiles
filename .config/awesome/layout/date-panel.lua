local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')
local clickable_container = require('widget.material.clickable-container')

local dpi = require('beautiful').xresources.apply_dpi

local icons = require('theme.icons')

local textclock = wibox.widget.textclock(
                      '<span font="Roboto bold 9">%d.%m.%Y\n     %H:%M</span>')

local date_widget = wibox.container.margin(textclock, dpi(8), dpi(8), dpi(8),
                                           dpi(8))

local DatePanel = function(s, offset)
    local offsetx = -dpi(122)
    local offsety = dpi(4)
    local panel = wibox({
        ontop = false,
        screen = s,
        height = dpi(32),
        width = dpi(80),
        x = s.geometry.width + offsetx,
        y = s.geometry.y + offsety,
        stretch = false,
        bg = beautiful.primary.hue_200,
        fg = beautiful.primary.hue_900,
        struts = {top = dpi(32)}
    })

    panel:setup{layout = wibox.layout.fixed.horizontal, date_widget}

    return panel
end

return DatePanel
