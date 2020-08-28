local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local apps = require('configuration.apps')
local dpi = require('beautiful').xresources.apply_dpi

local tags = {
    {text = 'web', type = 'web', defaultApp = apps.default.browser, screen = 1},
    {text = 'dev', type = 'dev', defaultApp = apps.default.editor, screen = 1},
    {
        text = 'term',
        type = 'term',
        defaultApp = apps.default.terminal,
        screen = 1
    },
    {text = 'file', type = 'file', defaultApp = apps.default.files, screen = 1},
    {text = 'chat', type = 'chat', defaultApp = apps.default.social, screen = 1},
    {text = 'misc', type = 'misc', defaultApp = apps.default.rofi, screen = 1}
}

awful.layout.layouts = {
    awful.layout.suit.tile, awful.layout.suit.max, awful.layout.suit.floating
}

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
