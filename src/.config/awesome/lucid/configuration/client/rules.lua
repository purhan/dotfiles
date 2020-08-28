local awful = require('awful')
local gears = require('gears')
local client_keys = require('configuration.client.keys')
local client_buttons = require('configuration.client.buttons')

-- Rules
awful.rules.rules = {{
    rule = {},
    properties = {
        focus = awful.client.focus.filter,
        raise = true,
        keys = client_keys,
        buttons = client_buttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_offscreen,
        floating = false,
        maximized = false,
        above = false,
        below = false,
        ontop = false,
        sticky = false,
        maximized_horizontal = false,
        maximized_vertical = false
    }
}, {
    rule_any = {
        type = {'dialog'},
        class = {'Wicd-client.py', 'calendar.google.com'}
    },
    properties = {
        placement = awful.placement.centered,
        ontop = true,
        floating = true,
        drawBackdrop = true,
        shape = function()
            return function(cr, w, h)
                gears.shape.rounded_rect(cr, w, h, 8)
            end
        end,
        skip_decoration = true
    }
}, {
    rule_any = {
        type = {'modal'}
    },
    properties = {
        titlebars_enabled = true,
        floating = true,
        above = true,
        skip_decoration = true,
        placement = awful.placement.centered
    }
}, {
    rule_any = {
        type = {'utility'}
    },
    properties = {
        titlebars_enabled = false,
        floating = true,
        skip_decoration = true,
        placement = awful.placement.centered
    }
}, {
    rule_any = {
        type = {'splash'},
        name = {'Discord Updater'}
    },
    properties = {
        floating = true,
        above = true,
        skip_decoration = true,
        placement = awful.placement.centered
    }
}}
