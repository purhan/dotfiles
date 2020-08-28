local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')
local icons = require('theme.icons')
local clickable_container = require('widget.material.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi

local styles = {}
local function rounded_shape(size, partial)
    if partial then
        return function(cr, width, height)
            gears.shape.rectangle(cr, width + 5, height, 11)
        end
    else
        return function(cr, width, height)
            gears.shape.rectangle(cr, width, height, size)
        end
    end
end
styles.month = {padding = 5, bg_color = '#555555', shape = rounded_shape(10)}
styles.normal = {shape = rounded_shape(5)}
styles.focus = {
    fg_color = beautiful.primary.hue_400, -- Current day Color
    markup = function(t) return '<b>' .. t .. '</b>' end,
    shape = rounded_shape(5, true)
}
styles.header = {
    fg_color = beautiful.primary.hue_200, -- Month Name Color
    markup = function(t) return '<b>' .. t .. '</b>' end,
    shape = rounded_shape(10)
}
styles.weekday = {
    fg_color = beautiful.background.hue_50, -- Day Color
    markup = function(t) return '<b>' .. t .. '</b>' end,
    shape = rounded_shape(5)
}
local function decorate_cell(widget, flag, date)
    if flag == 'monthheader' and not styles.monthheader then flag = 'header' end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    local d = {
        year = date.year,
        month = (date.month or 1),
        day = (date.day or 1)
    }
    local weekday = tonumber(os.date('%w', os.time(d)))
    local ret = wibox.widget {
        {
            widget,
            margins = (props.padding or 2) + (props.border_width or 0),
            widget = wibox.container.margin
        },
        fg = props.fg_color or '#999999',
        widget = wibox.container.background
    }
    return ret
end

local cal = wibox.widget {
    date = os.date('*t'),
    font = 'Roboto 10',
    fn_embed = decorate_cell,
    start_sunday = true,
    widget = wibox.widget.calendar.month
}

return cal
