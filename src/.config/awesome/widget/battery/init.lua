-------------------------------------------------
-- Battery Widget for Awesome Window Manager
-- Shows the battery status using the ACPI tool
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/battery-widget
-- @author Pavel Makhov
-- @copyright 2017 Pavel Makhov
-------------------------------------------------
local awful = require('awful')
local naughty = require('naughty')
local watch = require('awful.widget.watch')
local wibox = require('wibox')
local clickable_container = require('widget.material.clickable-container')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local apps = require('configuration.apps')

-- acpi sample outputs
-- Battery 0: Discharging, 75%, 01:51:38 remaining
-- Battery 0: Charging, 53%, 00:57:43 until charged

local HOME = os.getenv('HOME')
local PATH_TO_ICONS = HOME .. '/.config/awesome/widget/battery/icons/'
local percentage = wibox.widget.textbox()

local widget = wibox.widget {
    {
        id = 'icon',
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.fixed.horizontal
}

local battery_widget = wibox.widget {
    wibox.container.margin(widget, dpi(4), dpi(4), dpi(3), dpi(3)),
    wibox.container.margin(percentage, dpi(0), dpi(4), dpi(4), dpi(4)),
    layout = wibox.layout.fixed.horizontal
}

-- Alternative to naughty.notify - tooltip. You can compare both and choose the preferred one
local battery_popup = awful.tooltip({
    objects = {battery_widget},
    mode = 'outside',
    align = 'left',
    preferred_positions = {'right', 'left', 'top', 'bottom'}
})

-- To use colors from beautiful theme put
-- following lines in rc.lua before require("battery"):
-- beautiful.tooltip_fg = beautiful.fg_normal
-- beautiful.tooltip_bg = beautiful.bg_normal

watch('acpi -i', 1, function(_, stdout)
    local batteryIconName = 'battery'

    local battery_info = {}
    local capacities = {}
    for s in stdout:gmatch('[^\r\n]+') do
        local status, charge_str, time = string.match(s, '.+: (%a+), (%d?%d?%d)%%,?.*')
        if status ~= nil then
            table.insert(battery_info, {
                status = status,
                charge = tonumber(charge_str)
            })
        else
            local cap_str = string.match(s, '.+:.+last full capacity (%d+)')
            table.insert(capacities, tonumber(cap_str))
        end
    end

    local capacity = 0
    for _, cap in ipairs(capacities) do
        capacity = capacity + cap
    end

    local charge = 0
    local status
    for i, batt in ipairs(battery_info) do
        if batt.charge >= charge then
            status = batt.status -- use most charged battery status
           -- this is arbitrary, and maybe another metric should be used
        end

        charge = charge + batt.charge * capacities[i]
    end
    charge = charge / capacity

    if status == 'Charging' or status == 'Full' then
        batteryIconName = batteryIconName .. '-charging'
    end

    local roundedCharge = math.floor(charge / 10) * 10
    if (roundedCharge == 0) then
        batteryIconName = batteryIconName .. '-outline'
    elseif (roundedCharge ~= 100) then
        batteryIconName = batteryIconName .. '-' .. roundedCharge
    end

    widget.icon:set_image(PATH_TO_ICONS .. batteryIconName .. '.svg')
    -- Update popup text
    battery_popup.text = string.gsub(stdout, '\n$', '')
    percentage.text = math.floor(charge)
    collectgarbage('collect')
end, widget)

return battery_widget
