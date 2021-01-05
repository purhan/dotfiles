local wibox = require('wibox')
local beautiful = require('beautiful')

local clock = wibox.widget.textclock('<span font="' .. beautiful.font .. '">%d/%m %a %H:%M</span>')
return clock
