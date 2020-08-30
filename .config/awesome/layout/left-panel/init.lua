local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local apps = require('configuration.apps')
local dpi = require('beautiful').xresources.apply_dpi

local left_panel = function(screen)
    local action_bar_width = dpi(32)
    local panel_content_width = dpi(400)
    local offsety = dpi(4)

    local panel = wibox {
        screen = screen,
        width = dpi(32),
        height = dpi(32),
        x = screen.geometry.x + 4,
        y = screen.geometry.y + offsety,
        ontop = false,
        bg = beautiful.primary.hue_900,
        fg = beautiful.fg_normal
    }

    panel.opened = false

    panel:struts({left = dpi(0), top = dpi(36)})

    local backdrop = wibox {
        ontop = true,
        screen = screen,
        bg = '#00000000',
        type = 'dock',
        x = screen.geometry.x,
        y = screen.geometry.y + offsety,
        width = screen.geometry.width,
        height = screen.geometry.height
    }

    function panel:run_rofi()
        _G.awesome.spawn(apps.default.rofi, false, false, false, false,
                         function() panel:toggle() end)
    end

    local openPanel = function(should_run_rofi)
        panel.width = panel_content_width
        panel.height = screen.geometry.height
        backdrop.visible = true
        panel.visible = false
        panel.visible = true
        panel.x = screen.geometry.x
        panel.y = screen.geometry.y
        panel.ontop = true
        panel:get_children_by_id('panel_content')[1].visible = true
        if should_run_rofi then panel:run_rofi() end
        panel:emit_signal('opened')
    end

    local closePanel = function()
        panel.width = action_bar_width
        panel.height = dpi(32)
        panel:get_children_by_id('panel_content')[1].visible = false
        backdrop.visible = false
        panel.ontop = false
        panel.x = screen.geometry.x + 12
        panel.y = screen.geometry.y + offsety
        panel:emit_signal('closed')
    end

    function panel:toggle(should_run_rofi)
        self.opened = not self.opened
        if self.opened then
            openPanel(should_run_rofi)
        else
            closePanel()
        end
    end

    backdrop:buttons(awful.util.table.join(
                         awful.button({}, 1, function() panel:toggle() end)))

    panel:setup{
        require('layout.left-panel.action-bar')(screen, panel, action_bar_width),
        layout = wibox.layout.align.vertical,
        {
            id = 'panel_content',
            bg = beautiful.primary.hue_900,
            widget = wibox.container.background,
            visible = false,
            forced_width = panel_content_width,
            {
                require('layout.left-panel.dashboard')(screen, panel),
                layout = wibox.layout.stack
            }
        }
    }
    return panel
end

return left_panel
