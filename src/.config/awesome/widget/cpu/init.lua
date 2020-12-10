local wibox = require('wibox')
local beautiful = require('beautiful')
local icons = require('theme.icons')
local dpi = require('beautiful').xresources.apply_dpi
local watch = require('awful.widget.watch')

local icon = wibox.widget {
    wibox.widget {
        image = icons.cpu,
        widget = wibox.widget.imagebox
    },
    top = dpi(3),
    bottom = dpi(3),
    widget = wibox.container.margin
}

local percentage = wibox.widget.textbox()
local total_prev = 0
local idle_prev = 0

watch([[bash -c "cat /proc/stat | grep '^cpu '"]], 1, function(_, stdout)
    local user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice =
        stdout:match('(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s')

    local total = user + nice + system + idle + iowait + irq + softirq + steal

    local diff_idle = idle - idle_prev
    local diff_total = total - total_prev
    local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

    percentage.text = math.floor(diff_usage) .. '%'

    total_prev = total
    idle_prev = idle
    collectgarbage('collect')
end)

local cpu_widget = wibox.widget {
    icon,
    wibox.container.margin(percentage, dpi(4), dpi(4), dpi(4), dpi(4)),
    layout = wibox.layout.fixed.horizontal
}

return wibox.container.margin(cpu_widget, dpi(4), dpi(4))
