local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local apps = require('configuration.apps')
local dpi = require('beautiful').xresources.apply_dpi

local tags = {{
    text = 'web',
    screen = 1
}, {
    text = 'dev',
    screen = 1
}, {
    text = 'term',
    screen = 1
}, {
    text = 'file',
    screen = 1
}, {
    text = 'chat',
    screen = 1
}, {
    text = 'misc',
    screen = 1
}}

awful.layout.layouts = {awful.layout.suit.tile, awful.layout.suit.max, awful.layout.suit.floating}

awful.screen.connect_for_each_screen(function(s)
    for i, tag in pairs(tags) do
        awful.tag.add(tag.text, {
            icon = tag.icon,
            icon_only = false,
            layout = awful.layout.suit.tile,
            gap = beautiful.gaps,
            screen = s,
            defaultApp = tag.defaultApp,
            selected = i == 1
        })
    end
end)
