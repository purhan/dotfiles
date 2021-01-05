local awful = require('awful')
local app = require('configuration.apps').default.splash
local dpi = require('beautiful').xresources.apply_dpi
local beautiful = require('beautiful')
local screen = awful.screen.focused()

-- Theme
beautiful.init(require('theme'))

local splash_id = 'notnil'
local splash_client
local opened = false

function create_shell()
    splash_id = awful.spawn.with_shell(app)
end

-- Dirty hack to prevent splash from showing up in occupied tags
function _splash_to_current_tag()
    if splash_client then
        splash_client:move_to_tag(screen.selected_tag)
    end
end

function open_splash()
    splash_client.hidden = false
end

function close_splash()
    splash_client.hidden = true
end

toggle_splash_height = function()
    if splash_client and opened then
        splash_client.maximized_vertical = not splash_client.maximized_vertical
    end
end

toggle_splash = function()
    opened = not opened
    if not splash_client then
        create_shell()
    else
        if opened then
            open_splash()
            client.focus = splash_client
            splash_client:raise()
        else
            close_splash()
        end
    end
end

_G.client.connect_signal('manage', function(c)
    if (c.pid == splash_id) then
        splash_client = c
        c.x = c.screen.geometry.x
        c.height = (c.screen.geometry.height / 5) * 3
        c.y = c.screen.geometry.height - c.height - beautiful.border_width - dpi(16)
        c.floating = true
        c.skip_taskbar = true
        c.skip_decoration = true
        c.ontop = true
        c.floating = true
        c.above = true
        c.sticky = true
        c.type = 'splash'
        c.hidden = not opened
        c.border_width = beautiful.border_width
        c.maximized_horizontal = true
    end
end)

_G.client.connect_signal('unmanage', function(c)
    if (c.pid == splash_id) then
        opened = false
        splash_client = nil
    end
end)
