local awful = require('awful')
local spawn = require('awful.spawn')
local app = require('configuration.apps').default.quake
local dpi = require('beautiful').xresources.apply_dpi
local beautiful = require('beautiful')

-- Theme
beautiful.init(require('theme'))

local quake_id = 'notnil'
local quake_client
local opened = false
function create_shell() quake_id = spawn(app, {skip_decoration = true}) end

function open_quake() quake_client.hidden = false end

function close_quake() quake_client.hidden = true end

toggle_quake = function()
    opened = not opened
    if not quake_client then
        create_shell()
    else
        if opened then
            open_quake()
            client.focus = quake_client
            quake_client:raise()
            --       awful.client.focus(quake_id)
        else
            close_quake()
        end
    end
end

_G.client.connect_signal('manage', function(c)
    if (c.pid == quake_id) then
        quake_client = c
        c.x = c.screen.geometry.x
        c.y = c.screen.geometry.height - c.height
        c.opacity = 0.9
        c.floating = true
        c.skip_taskbar = true
        c.ontop = true
        c.above = true
        c.sticky = true
        c.type = 'dock'
        c.hidden = not opened
        c.maximized_horizontal = true
        c.border_width = dpi(1)
    end
end)

_G.client.connect_signal('unmanage', function(c)
    if (c.pid == quake_id) then
        opened = false
        quake_client = nil
    end
end)
