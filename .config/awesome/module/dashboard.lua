local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')
local icons = require('theme.icons')
local mat_list_item = require('widget.material.list-item')
local mat_icon = require('widget.material.icon')
local clickable_container = require('widget.material.clickable-container')
local apps = require('configuration.apps')
local dpi = require('beautiful').xresources.apply_dpi

local icon_size = beautiful.dashboard_icon_size or dpi(140)

local username = os.getenv("USER")

local panel_style = gears.shape.rounded_rect

local buildButton = function(icon, name)
    local button_text = wibox.widget {
        text = name,
        font = beautiful.font,
        align = 'center',
        valign = 'center',
        bg = beautiful.primary.hue_900,
        fg = beautiful.fg_normal,
        widget = wibox.widget.textbox
    }

    local a_button = wibox.widget {
        {
            {
                {
                    {image = icon, widget = wibox.widget.imagebox},
                    margins = dpi(16),
                    widget = wibox.container.margin
                },
                bg = beautiful.groups_bg,
                widget = wibox.container.background
            },
            shape = panel_style,
            forced_width = dpi(60),
            forced_height = dpi(60),
            visible = true,
            -- bg = beautiful.bg_normal,
            widget = clickable_container

        },
        visible = true,
        -- bg = beautiful.bg_normal,
        shape = panel_style,
        widget = wibox.container.background
    }

    local build_a_button = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(5),
        a_button
        -- button_text
    }

    return build_a_button
end

local buildLabel = function(name)
    local label_text = wibox.widget {
        {
            text = name,
            font = 'Roboto 11',
            align = 'center',
            valign = 'center',
            bg = beautiful.primary.hue_900,
            fg = beautiful.fg_normal,
            widget = wibox.widget.textbox
        },
        shape = panel_style,
        forced_height = dpi(56),
        visible = true,
        -- bg = beautiful.bg_normal,
        widget = clickable_container
    }

    local build_a_label = wibox.widget {
        layout = wibox.layout.flex.horizontal,
        spacing = dpi(5),
        label_text
    }

    return build_a_label
end

function suspend_command()
    dashboard_hide()
    awful.spawn.with_shell(apps.default.lock .. ' & systemctl suspend')
end
function exit_command() _G.awesome.quit() end
function lock_command()
    dashboard_hide()
    awful.spawn.with_shell('sleep 1 && ' .. apps.default.lock)
end
function poweroff_command()
    awful.spawn.with_shell('poweroff')
    awful.keygrabber.stop(_G.dashboard_grabber)
end
function reboot_command()
    awful.spawn.with_shell('reboot')
    awful.keygrabber.stop(_G.dashboard_grabber)
end

local poweroff = buildButton(icons.power, 'Shutdown')
poweroff:connect_signal('button::release', function() poweroff_command() end)

local reboot = buildButton(icons.restart, 'Restart')
reboot:connect_signal('button::release', function() reboot_command() end)

local suspend = buildButton(icons.sleep, 'Sleep')
suspend:connect_signal('button::release', function() suspend_command() end)

local exit = buildButton(icons.logout, 'Logout')
exit:connect_signal('button::release', function() exit_command() end)

local lock = buildButton(icons.lock, 'Lock')
lock:connect_signal('button::release', function() lock_command() end)

local search = buildButton(icons.search, 'Search')
search:connect_signal('button::release', function()
    -- rofi_command()
    dashboard_hide()
    _G.awesome.spawn(apps.default.rofi)
end)

local close = buildButton(icons.close_dark, 'Close')
close:connect_signal('button::release', function() dashboard_hide() end)

-- Get screen geometry
local screen_geometry = awful.screen.focused().geometry

-- Create the widget
dashboard = wibox({
    x = screen_geometry.x,
    y = screen_geometry.y,
    visible = false,
    ontop = true,
    type = 'splash',
    bg = beautiful.primary.hue_800 .. '66',
    height = screen_geometry.height,
    width = screen_geometry.width
})

local dashboard_grabber

function dashboard_hide()
    awful.keygrabber.stop(dashboard_grabber)
    dashboard.visible = false
end

function dashboard_show()
    dashboard_grabber = awful.keygrabber.run(
                            function(_, key, event)
            if event == 'release' then return end

            if key == 'Escape' or key == 'q' or key == 'x' or key == 'm' then
                dashboard_hide()
            end
        end)
    dashboard.visible = true
end

dashboard:buttons(gears.table.join( -- Middle click - Hide dashboard
awful.button({}, 2, function() dashboard_hide() end),
awful.button({}, 3, function() dashboard_hide() end)))

local profile_picture = os.getenv("HOME") ..
                            "/.config/awesome/user_picture_curved.png"

local profile = wibox.widget {
    wibox.widget {
        {
            {
                {
                    {
                        image = profile_picture,
                        resize = true,
                        widget = wibox.widget.imagebox
                    },
                    resize = true,
                    top = dpi(12),
                    right = dpi(12),
                    left = dpi(12),
                    widget = wibox.container.margin
                },
                bg = beautiful.groups_bg,
                shape = panel_style,
                widget = wibox.container.background
            },
            forced_width = dpi(244),
            forced_height = dpi(244),
            visible = true,
            bg = beautiful.bg_normal,
            shape = panel_style,
            widget = wibox.container.background
        },
        wibox.widget {
            {
                wibox.widget {
                    text = '@' .. username,
                    font = "Roboto Regular 12",
                    align = 'center',
                    valign = 'center',
                    widget = wibox.widget.textbox
                },
                bottom = dpi(8),
                widget = wibox.container.margin
            },
            fg = beautiful.primary.hue_500,
            widget = wibox.container.background
        },
        layout = wibox.layout.fixed.vertical
    },
    visible = true,
    bg = beautiful.bg_normal,
    shape = panel_style,
    widget = wibox.container.background
}

local power_options = wibox.widget {
    {
        poweroff,
        reboot,
        suspend,
        exit,
        lock,
        layout = wibox.layout.flex.horizontal
    },
    visible = true,
    bg = beautiful.primary.hue_900,
    shape = panel_style,
    widget = wibox.container.background
}

local search_button = wibox.widget {
    {
        search,
        bg = beautiful.primary.hue_600,
        layout = wibox.layout.fixed.vertical
    },
    visible = true,
    bg = beautiful.primary.hue_200,
    shape = panel_style,
    widget = wibox.container.background
}

local close_button = wibox.widget {
    {
        close,
        bg = beautiful.primary.hue_600,
        layout = wibox.layout.fixed.vertical
    },
    visible = true,
    bg = beautiful.primary.hue_350,
    shape = panel_style,
    widget = wibox.container.background
}

local quick_settings = wibox.widget {
    {
        {
            require('layout.left-panel.dashboard.quick-settings'),
            right = dpi(16),
            bottom = dpi(12),
            top = dpi(12),
            widget = wibox.container.margin
        },
        visible = true,
        bg = beautiful.bg_normal,
        shape = panel_style,
        widget = wibox.container.background
    },
    bg = beautiful.bg_normal,
    shape = panel_style,
    widget = wibox.container.background
}

local hardware_monitor = wibox.widget {
    {
        require('layout.left-panel.dashboard.hardware-monitor'),
        right = dpi(16),
        bottom = dpi(12),
        top = dpi(12),
        widget = wibox.container.margin
    },
    visible = true,
    bg = beautiful.bg_normal,
    shape = panel_style,
    widget = wibox.container.background
}

local cal = require('widget.calendar')

local calWidget = wibox.widget {
    {
        nil,
        {cal, margins = dpi(16), widget = wibox.container.margin},
        nil,
        layout = wibox.layout.flex.horizontal
    },
    resize = true,
    shape = panel_style,
    bg = beautiful.bg_normal,
    widget = wibox.container.background
}

-- Fortune widget				Credits: u/EmpressNoodle, github/elenapan
local fortune_command = "fortune -n 140 -s"
local fortune_update_interval = 3600
-- local fortune_command = "fortune -n 140 -s computers"
local fortune = wibox.widget {
    font = "Roboto 11",
    text = "You so poor you don't even have a cookie yet...",
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local update_fortune = function()
    awful.spawn.easy_async_with_shell(fortune_command, function(out)
        -- Remove trailing whitespaces
        out = out:gsub('^%s*(.-)%s*$', '%1')
        fortune.markup = "<i>" .. out .. "</i>"
    end)
end

gears.timer {
    autostart = true,
    timeout = fortune_update_interval,
    single_shot = false,
    call_now = true,
    callback = update_fortune
}

local fortune_widget = wibox.widget {
    {
        {fortune, layout = wibox.layout.flex.horizontal},
        margins = dpi(16),
        widget = wibox.container.margin
    },
    bg = beautiful.primary.hue_700,
    fg = beautiful.primary.hue_900,
    shape = panel_style,
    forced_height = dpi(112),
    widget = wibox.container.background
}

local uptime_text = wibox.widget.textbox()
uptime_text.font = "Roboto 10"
uptime_text.valign = "center"
awful.widget.watch("uptime -p | sed 's/^...//'", 60, function(_, stdout)
    local out = stdout:gsub('^%s*(.-)%s*up', '%1')
    uptime_text.text = out
end)

local uptime_widget = wibox.widget {
    {
        {
            {
                image = icons.uptime,
                resize = true,
                forced_width = dpi(24),
                widget = wibox.widget.imagebox
            },
            uptime_text,
            spacing = dpi(8),
            layout = wibox.layout.fixed.horizontal
        },
        margins = dpi(16),
        widget = wibox.container.margin
    },
    bg = beautiful.bg_normal,
    shape = panel_style,
    forced_height = dpi(48),
    forced_width = dpi(182),
    widget = wibox.container.background
}

-- Bookmarks
function reddit_command()
    dashboard_hide()
    awful.spawn(apps.default.browser .. " " .. "reddit.com")
end

function youtube_command()
    dashboard_hide()
    awful.spawn(apps.default.browser .. " " .. "youtube.com")
end

function linkedin_command()
    dashboard_hide()
    awful.spawn(apps.default.browser .. " " .. "linkedin.com")
end

function github_command()
    dashboard_hide()
    awful.spawn(apps.default.browser .. " " .. "github.com")
end

function deviantart_command()
    dashboard_hide()
    awful.spawn(apps.default.browser .. " " .. "deviantart.com")
end

function codeforces_command()
    dashboard_hide()
    awful.spawn(apps.default.browser .. " " .. "codeforces.com")
end

function files_command(directory)
    dashboard_hide()
    awful.spawn(apps.default.files .. " " .. directory)
end

local reddit = buildButton(icons.reddit, 'Reddit')
reddit:connect_signal('button::release', function() reddit_command() end)

local youtube = buildButton(icons.youtube, 'Youtube')
youtube:connect_signal('button::release', function() youtube_command() end)

local linkedin = buildButton(icons.linkedin, 'Linkedin')
linkedin:connect_signal('button::release', function() linkedin_command() end)

local github = buildButton(icons.github, 'Github')
github:connect_signal('button::release', function() github_command() end)

local deviantart = buildButton(icons.deviantart, 'Deviantart')
deviantart:connect_signal('button::release', function() deviantart_command() end)

local codeforces = buildButton(icons.codeforces, 'Codeforces')
codeforces:connect_signal('button::release', function() codeforces_command() end)

local home = buildLabel('Home')
home:connect_signal('button::release', function() files_command(".") end)

local downloads = buildLabel('Downloads')
downloads:connect_signal('button::release',
                         function() files_command("Downloads") end)

local desktop = buildLabel('Desktop')
desktop:connect_signal('button::release',
                       function() files_command("Desktop") end)

local pictures = buildLabel('Pictures')
pictures:connect_signal('button::release',
                        function() files_command("Pictures") end)

local videos = buildLabel('Videos')
videos:connect_signal('button::release', function() files_command("Videos") end)

local documents = buildLabel('Documents')
documents:connect_signal('button::release',
                         function() files_command("Documents") end)

local bookmarks = wibox.widget {
    {
        {reddit, youtube, linkedin, layout = wibox.layout.flex.horizontal},
        {github, deviantart, codeforces, layout = wibox.layout.ratio.horizontal},
        layout = wibox.layout.fixed.vertical
    },
    visible = true,
    bg = beautiful.bg_normal,
    shape = panel_style,
    forced_width = dpi(182),
    widget = wibox.container.background
}

local places = wibox.widget {
    {
        {
            home,
            desktop,
            downloads,
            pictures,
            documents,
            videos,
            layout = wibox.layout.fixed.vertical
        },
        layout = wibox.layout.fixed.vertical
    },
    visible = true,
    bg = beautiful.bg_normal,
    shape = panel_style,
    forced_width = dpi(182),
    widget = wibox.container.background
}

-- Item placement
dashboard:setup{
    nil,
    {
        nil,
        {
            {
                search_button,
                close_button,
                spacing = dpi(10),
                layout = wibox.layout.fixed.vertical
            },
            {
                {
                    {
                        quick_settings,
                        hardware_monitor,
                        fortune_widget,
                        forced_width = dpi(300),
                        spacing = dpi(10),
                        layout = wibox.layout.fixed.vertical
                    },
                    {
                        bookmarks,
                        places,
                        spacing = dpi(10),
                        layout = wibox.layout.fixed.vertical
                    },
                    spacing = dpi(10),
                    layout = wibox.layout.fixed.horizontal
                },
                {
                    power_options,
                    uptime_widget,
                    spacing = dpi(10),
                    layout = wibox.layout.fixed.horizontal
                },
                spacing = dpi(10),
                layout = wibox.layout.fixed.vertical
            },
            {
                profile,
                calWidget,
                spacing = dpi(10),
                layout = wibox.layout.fixed.vertical
            },
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal
        },
        nil,
        expand = 'none',
        layout = wibox.layout.align.horizontal
    },
    {nil, expand = 'none', layout = wibox.layout.align.horizontal},
    expand = 'none',
    layout = wibox.layout.align.vertical
}
