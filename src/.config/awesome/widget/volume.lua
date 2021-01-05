local awful = require("awful")
local wibox = require('wibox')
local mat_list_item = require('widget.material.list-item')
local dpi = require('beautiful').xresources.apply_dpi
local watch = require('awful.widget.watch')
local beautiful = require('beautiful')

local volume_icon = wibox.widget.textbox()
volume_icon.font = beautiful.icon_font
local volume_widget = wibox.widget.textbox()
volume_widget.align = 'center'
volume_widget.valign = 'center'
volume_widget.font = beautiful.font

local volume

function update_volume()
    awful.spawn.easy_async_with_shell("bash -c 'amixer -D pulse sget Master'", function(stdout)
        volume = string.match(stdout, '(%d?%d?%d)%%')
        awful.spawn.easy_async_with_shell("bash -c 'pacmd list-sinks | awk '/muted/ { print $2 }''", function(muted)
            volume_widget.text = volume
            muted = string.gsub(muted, "%s+", "")
            if muted == 'muted:no' and (volume > '35' or volume == '100') then
                volume_icon.text = '墳'
            elseif muted == 'muted:no' and volume <= '35' and volume > '0' then
                volume_icon.text = '奔'
            elseif muted == 'muted:yes' then
                volume_icon.text = '婢'
                volume_widget.text = 'M'
            elseif volume == '0' then
                volume_icon.text = '奄'
            end
        end)
        collectgarbage('collect')
    end)
end

watch('bash -c', 3, function(_, stdout)
    update_volume()
end)

return wibox.widget {
    wibox.widget{
        volume_icon,
        fg = beautiful.accent.hue_100,
        widget = wibox.container.background
    },
    volume_widget,
    spacing = dpi(4),
    layout = wibox.layout.fixed.horizontal
}
