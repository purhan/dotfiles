local awful = require('awful')
local beautiful = require('beautiful')
local clickable_container = require('widget.material.clickable-container')
local mat_icon_button = require('widget.material.icon-button')
local wibox = require('wibox')
local TagList = require('widget.tag-list')
local TaskList = require('widget.task-list')
local gears = require('gears')
local icons = require('theme.icons')
local dpi = require('beautiful').xresources.apply_dpi

local separator = wibox.widget {
    orientation = 'vertical',
    forced_width = dpi(2),
    opacity = 0.5,
    widget = wibox.widget.separator
}

local TopBar = function(s, offset)

    -- LAYOUT BOX
    -- ==========
    local LayoutBox = require('widget.layoutbox')

    -- BATTERY
    -- =======
    local battery_widget = require('widget.battery')

    -- SYSTEM TRAY
    -- ===========
    local systray = wibox.widget.systray()
    systray:set_horizontal(true)

    -- TASK LIST
    -- =========
    local task_list = wibox.widget {
        nil,
        wibox.container.margin(TaskList(s), dpi(2), dpi(2), dpi(3), dpi(3)),
        nil,
        layout = wibox.layout.align.horizontal
    }

    -- SYSTEM DETAILS
    -- ==============
    local volume_widget = require('widget.volume.volume-percentage')
    local date_widget = require('widget.date')
    local clock_widget = require('widget.clock')
    local mem_widget = require('widget.memory')
    local cpu_widget = require('widget.cpu')
    local system_details = wibox.widget {
        wibox.widget {
            wibox.container.background(systray, beautiful.primary.hue_800),
            wibox.container.background(battery_widget, beautiful.primary.hue_800),
            separator,
            wibox.container.background(mem_widget, beautiful.primary.hue_800),
            separator,
            wibox.container.background(cpu_widget, beautiful.primary.hue_800),
            separator,
            wibox.container.background(volume_widget, beautiful.primary.hue_800),
            separator,
            wibox.container.background(date_widget, beautiful.primary.hue_800),
            separator,
            wibox.container.background(clock_widget, beautiful.primary.hue_800),
            layout = wibox.layout.fixed.horizontal
        },
        bg = beautiful.primary.hue_900,
        widget = wibox.container.background
    }

    local calendar = require('widget.calendar')
    calendar:attach(date_widget)

    -- TOP BAR
    -- =======
    local panel = wibox({
        ontop = false,
        screen = s,
        height = dpi(24),
        width = s.geometry.width,
        x = s.geometry.x,
        y = s.geometry.y,
        stretch = false,
        bg = beautiful.primary.hue_900,
        fg = beautiful.fg_normal
    })

    panel:struts({
        top = panel.height - panel.y
    })

    panel:setup{
        layout = wibox.layout.align.horizontal,
        spacing = dpi(0),
        TagList(s),
        task_list,
        wibox.widget {
            wibox.container.margin(system_details, dpi(2), dpi(2), dpi(3), dpi(3)),
            LayoutBox(s),
            layout = wibox.layout.fixed.horizontal
        }
    }

    return panel
end

return TopBar
