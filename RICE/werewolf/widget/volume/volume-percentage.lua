local wibox = require('wibox')
local mat_list_item = require('widget.material.list-item')
local dpi = require('beautiful').xresources.apply_dpi
local watch = require('awful.widget.watch')

local percentage = wibox.widget.textbox()
percentage.align = 'center'
percentage.valign = 'center'

watch([[bash -c "amixer -D pulse sget Master"]], 0, function(_, stdout)
    local mute = string.match(stdout, '%[(o%D%D?)%]')
    local volume = string.match(stdout, '(%d?%d?%d)%%')
    percentage.text = volume
    collectgarbage('collect')
end)

local volume_setting = wibox.widget {
    percentage,
    forced_width = dpi(32),
    widget = wibox.container.background
}

return volume_setting
