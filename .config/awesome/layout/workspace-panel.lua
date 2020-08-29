local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local TagList = require('widget.tag-list')
local gears = require('gears')

local dpi = require('beautiful').xresources.apply_dpi

local WorkspacePanel = function(s, offset)
    local offsetx = 0
    if offset == true then
        offsetx = dpi(42)
        offsety = dpi(4)
    end
    local panel = wibox({
        ontop = false,
        screen = s,
        height = dpi(32),
        width = dpi(180),
        x = s.geometry.x + offsetx,
        y = s.geometry.y + offsety,
        stretch = false,
        bg = beautiful.primary.hue_900,
        fg = beautiful.fg_normal,
        struts = {top = dpi(32)}
    })

    panel:setup{layout = wibox.layout.align.horizontal, TagList(s)}

    return panel
end

return WorkspacePanel
