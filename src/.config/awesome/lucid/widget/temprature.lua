local wibox = require('wibox')
local watch = require('awful.widget.watch')
local beautiful = require('beautiful')

local temprature = wibox.widget.textbox()
temprature.font = beautiful.font

watch('bash -c "sensors | awk \'/Core 0/ {print substr($3, 2) }\'"', 30, function(_, stdout)
    temprature.text = stdout
end)

return temprature
