local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('theme.icons')

local icon = wibox.widget {
    {
        {image = icons.volume_dark, widget = wibox.widget.imagebox},
        margins = dpi(6),
        layout = wibox.container.margin
    },
    bg = beautiful.primary.hue_200,
    widget = wibox.container.background
}

local volume_percentage_widget = wibox.container.background(
                                     require('widget.volume.volume-percentage'))

local VolumePanel = function(s, offset)
    local offsetx = dpi(228)
    if offset == true then offsety = dpi(4) end
    local panel = wibox({
        ontop = false,
        screen = s,
        height = dpi(32),
        width = dpi(64),
        x = s.geometry.x + offsetx,
        y = s.geometry.y + offsety,
        stretch = false,
        bg = beautiful.primary.hue_900,
        fg = beautiful.fg_normal
    })

    panel:setup{
        layout = wibox.layout.fixed.horizontal,
        icon,
        volume_percentage_widget
    }

    return panel
end

return VolumePanel
