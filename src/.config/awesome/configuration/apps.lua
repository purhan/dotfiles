local filesystem = require('gears.filesystem')
local beautiful = require('beautiful')

-- Thanks to jo148 on github for making rofi dpi aware!
local with_dpi = require('beautiful').xresources.apply_dpi
local get_dpi = require('beautiful').xresources.get_dpi
local rofi_command = 'env /usr/bin/rofi -show drun -display-drun -run-command "/bin/bash -c -i \'shopt -s expand_aliases; {cmd}\'"'

return {
    -- List of apps to start by default on some actions
    default = {
        terminal = 'kitty',
        rofi = rofi_command,
        lock = 'i3lock-fancy',
        splash = 'kitty -T SplashTerminal -o background_opacity=0.95',
        power_command = '~/.config/awesome/configuration/utils/rofi-power',
        screenshot = '~/.config/awesome/configuration/utils/screenshot -m',
        region_screenshot = '~/.config/awesome/configuration/utils/screenshot -r',
        delayed_screenshot = '~/.config/awesome/configuration/utils/screenshot --delayed -r',
        browser = 'env firefox',
        editor = 'gvim',
        social = 'env discord',
        files = 'nautilus',
        power_manager = 'gnome-power-statistics'
    },
    -- List of commands to start once on start-up
    run_on_start_up = {
        '~/.config/awesome/configuration/awspawn',
        'compton',
        'nm-applet --indicator',
        'nitrogen --restore',
        'ibus-daemon --xim --daemonize',
        'scream-start',
        'numlockx on',
        '/usr/lib/xfce-polkit/xfce-polkit & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', -- credential manager
        'blueman-tray'
    }
}

