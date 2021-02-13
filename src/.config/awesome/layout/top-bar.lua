local awful = require('awful')
local beautiful = require('beautiful')
local clickable_container = require('widget.material.clickable-container')
local mat_icon_button = require('widget.material.icon-button')
local separators = require('widget.material.separator')
local markup = require('widget.material.markup')
local wibox = require('wibox')
local TagList = require('widget.tag-list')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local table = awful.util.table or gears.table

-- Separators
local arrow = separators.arrow_left
local function create_arrow(mywidget, bgcolor, fgcolor)
    return (wibox.container.background(
        wibox.widget {
            arrow(fgcolor, bgcolor),
            mywidget,
            arrow(bgcolor, fgcolor),
            spacing = dpi(4),
            layout = wibox.layout.fixed.horizontal
        },
        bgcolor
    )
)
end

-- Create Icons
local function create_icon(label, icon_color)
    return (wibox.widget {
        wibox.widget{
            text = label,
            font = beautiful.icon_font,
            widget = wibox.widget.textbox
        },
        fg = icon_color,
        widget = wibox.container.background
    })
end

local TopBar = function(s, offset)

    -- LAYOUT BOX
    -- ==========
    local function update_txt_layoutbox(s)
        -- Writes a string representation of the current layout in a textbox widget
        local txt_l = beautiful["layout_txt_" .. awful.layout.getname(awful.layout.get(s))] or ""
        s.layoutbox:set_text(txt_l)
    end

    s.layoutbox = wibox.widget.textbox(beautiful["layout_txt_" .. awful.layout.getname(awful.layout.get(s))])
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
    local net = require('widget.net')
    local net_sent = net({
        settings = function()
            widget:set_markup(markup.font(beautiful.font, net_now.sent))
        end
    })
    local net_recieved = net({
        settings = function()
            widget:set_markup(markup.font(beautiful.font, net_now.received))
        end
    })
    local system_details = wibox.widget {
            -- Systray
            systray,
            create_arrow(nil, beautiful.primary.hue_200, beautiful.primary.hue_100),
            -- Internet Speed
            wibox.widget{
                create_icon('', beautiful.accent.hue_200),
                net_recieved.widget,
                create_icon('', beautiful.accent.hue_300),
                net_sent.widget,
                spacing = dpi(4),
                layout = wibox.layout.fixed.horizontal
            },
            -- Battery
            create_arrow (battery_widget, beautiful.primary.hue_200, beautiful.primary.hue_100),
            -- Memory
            create_icon('', beautiful.accent.hue_500),
            mem_widget,
            -- CPU
            create_arrow(wibox.widget{
                create_icon('﬙', beautiful.accent.hue_600),
                cpu_widget,
                spacing = dpi(4),
                layout = wibox.layout.fixed.horizontal
            }, beautiful.primary.hue_200, beautiful.primary.hue_100),
            -- Temprature
            wibox.widget{
                create_icon('﨎', beautiful.accent.hue_400),
                temprature_widget,
                spacing = dpi(4),
                layout = wibox.layout.fixed.horizontal
            },
            -- Volume
            create_arrow(volume_widget, beautiful.primary.hue_200, beautiful.primary.hue_100),
            -- Storage
            wibox.widget{
                create_icon('', beautiful.accent.hue_200),
                storage_widget,
                spacing = dpi(4),
                layout = wibox.layout.fixed.horizontal
            },
            wibox.widget{
            -- Calendar / Clock
                create_arrow(wibox.widget{
                    create_icon('', beautiful.accent.hue_400),
                    clock_widget,
                    spacing = dpi(4),
                    layout = wibox.layout.fixed.horizontal
                }, beautiful.primary.hue_200, beautiful.primary.hue_100),
            -- Layout
                wibox.widget {
                    arrow(beautiful.primary.hue_100, beautiful.accent.hue_200),
                    wibox.widget{
                        wibox.container.margin(s.layoutbox, dpi(4), dpi(4), dpi(0), dpi(0)),
                        fg = beautiful.primary.hue_100,
                        bg = beautiful.accent.hue_200,
                        widget = wibox.container.background
                    },
                    layout = wibox.layout.fixed.horizontal
                },
                layout = wibox.layout.fixed.horizontal,
            },
            spacing = dpi(4),
            layout = wibox.layout.fixed.horizontal
        }

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
