local filesystem = require('gears.filesystem')
local beautiful = require('beautiful')

-- Thanks to jo148 on github for making rofi dpi aware!
local with_dpi = require('beautiful').xresources.apply_dpi
local get_dpi = require('beautiful').xresources.get_dpi
local rofi_command = 'env /usr/bin/rofi -dpi ' .. get_dpi() .. ' -width ' .. with_dpi(100) ..
                         ' -show drun -display-drun -theme ' .. filesystem.get_configuration_dir() ..
                         '/configuration/rofi.rasi -icon-theme ' .. beautiful.icon_theme ..
                         ' -run-command "/bin/bash -c -i \'shopt -s expand_aliases; {cmd}\'"'

return {
    -- List of apps to start by default on some actions
    default = {
        terminal = 'kitty',
        rofi = rofi_command,
        lock = 'i3lock-fancy',
        quake = 'kitty',
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
    -- List of apps to start once on start-up
    run_on_start_up = {'~/.config/awesome/configuration/awspawn',
                       'compton --config ' .. filesystem.get_configuration_dir() .. '/configuration/compton.conf',
                       'nm-applet --indicator', 'ibus-daemon --xim --daemonize', 'scream-start', 'numlockx on',
                       '/usr/lib/xfce-polkit/xfce-polkit & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', -- credential manager
                       'blueman-tray',
                       'xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Natural Scrolling Enabled" 1',
                       'xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1'}
}

