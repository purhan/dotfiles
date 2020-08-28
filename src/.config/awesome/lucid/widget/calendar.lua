local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi

local month_calendar = awful.widget.calendar_popup.month({
    start_sunday = true,
    style_month = {
        border_width = dpi(0),
        bg_color = beautiful.primary.hue_100,
        padding = dpi(20)
    },
    style_header = {
        border_width = 0,
        fg_color = beautiful.accent.hue_400
    },
    style_weekday = {
        border_width = 0
    },
    style_normal = {
        border_width = 0
    },
    style_focus = {
        border_width = dpi(0),
        border_color = beautiful.fg_normal,
        fg_color = beautiful.accent.hue_200,
        bg_color = beautiful.primary.hue_100
    }
})

return month_calendar
