local awful = require('awful')
local beautiful = require('beautiful')
local clickable_container = require('widget.material.clickable-container')
local mat_icon_button = require('widget.material.icon-button')
local wibox = require('wibox')
local TagList = require('widget.tag-list')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local theme = require "theme"
local table = awful.util.table or gears.table

local separator = wibox.container.margin(wibox.widget {
    orientation = 'vertical',
    forced_width = dpi(1),
    opacity = 0.3,
    widget = wibox.widget.separator
}, dpi(0), dpi(0), dpi(4), dpi(4))

local TopBar = function(s, offset)

    -- LAYOUT BOX
    -- ==========
    local function update_txt_layoutbox(s)
        -- Writes a string representation of the current layout in a textbox widget
        local txt_l = theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))] or ""
        s.layoutbox:set_text(txt_l)
    end

    s.layoutbox = wibox.widget.textbox(theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))])
    s.layoutbox.font = beautiful.icon_font
    awful.tag.attached_connect_signal(s, "property::selected", function () update_txt_layoutbox(s) end)
    awful.tag.attached_connect_signal(s, "property::layout", function () update_txt_layoutbox(s) end)
    s.layoutbox:buttons(table.join(
                           awful.button({}, 1, function() awful.layout.inc(1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function() awful.layout.inc(-1) end),
                           awful.button({}, 4, function() awful.layout.inc(1) end),
                           awful.button({}, 5, function() awful.layout.inc(-1) end)))

    -- SYSTEM TRAY
    -- ===========
    local systray = wibox.widget.systray()
    systray:set_horizontal(true)

    -- SYSTEM DETAILS
    -- ==============
    local volume_widget = require('widget.volume')
    local battery_widget = require('widget.battery')
    local clock_widget = require('widget.clock')
    local mem_widget = require('widget.memory')
    local cpu_widget = require('widget.cpu')
    local temprature_widget = require('widget.temprature')
    local storage_widget = require('widget.storage')
    local system_details = wibox.widget {
            systray,
            separator,
            battery_widget,
            separator,
            wibox.widget{
                wibox.widget{
                    text = '',
                    font = beautiful.icon_font,
                    widget = wibox.widget.textbox
                },
                fg = beautiful.accent.hue_600,
                widget = wibox.container.background
            },
            mem_widget,
            separator,
            wibox.widget{
                wibox.widget{
                    text = '﬙',
                    font = beautiful.icon_font,
                    widget = wibox.widget.textbox
                },
                fg = beautiful.accent.hue_500,
                widget = wibox.container.background
            },
            cpu_widget,
            separator,
            wibox.widget{
                wibox.widget{
                    text = '﨎',
                    font = beautiful.icon_font,
                    widget = wibox.widget.textbox
                },
                fg = beautiful.accent.hue_400,
                widget = wibox.container.background
            },
            temprature_widget,
            separator,
            wibox.widget{
                wibox.widget{
                    text = '',
                    font = beautiful.icon_font,
                    widget = wibox.widget.textbox
                },
                fg = beautiful.accent.hue_200,
                widget = wibox.container.background
            },
            storage_widget,
            separator,
            volume_widget,
            separator,
            wibox.widget{
                wibox.widget{
                    text = '',
                    font = beautiful.icon_font,
                    widget = wibox.widget.textbox
                },
                fg = beautiful.accent.hue_400,
                widget = wibox.container.background
            },
            clock_widget,
            wibox.widget{
                s.layoutbox,
                fg = beautiful.primary.hue_100,
                bg = beautiful.accent.hue_200,
                widget = wibox.container.background
            },
            spacing = dpi(4),
            layout = wibox.layout.fixed.horizontal
        }

    local calendar = require('widget.calendar')
    calendar:attach(clock_widget)

    -- TOP BAR
    -- =======
    local panel = wibox({
        ontop = false,
        screen = s,
        height = dpi(20),
        width = s.geometry.width,
        x = s.geometry.x,
        y = s.geometry.y,
        stretch = false,
        bg = beautiful.primary.hue_100,
        fg = beautiful.fg_normal,
    })

    panel:struts({
        top = panel.height - panel.y
    })

    panel:setup{
        layout = wibox.layout.align.horizontal,
        TagList(s),
        nil,
        system_details,
    }

    return panel
end

return TopBar
