import os
import subprocess

from typing import List

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = "kitty"
rofi = """
env /usr/bin/rofi -show drun -display-drun -run-command
"/bin/bash -c -i 'shopt -s expand_aliases; {cmd}'"
"""
config_directory = os.path.expanduser("~/.config/qtile")

BLACK = "#212121"
LIGHT_GREY = "#3c3c3c"
GREY = "#333333"
DARK_GREY = "#1a1a1a"
YELLOW = "#e1be7f"
GREEN = "#92c96a"
BLUE = "#66aeea"
RED = "#f35a5a"
CYAN = "#4083bc"
MAGENTA = "#c57cda"
ORANGE = "#cd996a"
WHITE = "#d6d6d6"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down(), desc="Move focus down in stack pane"),
    Key([mod], "j", lazy.layout.up(), desc="Move focus up in stack pane"),
    # Move windows up or down in current stack
    Key(
        [mod, "control"],
        "k",
        lazy.layout.shuffle_down(),
        desc="Move window down in current stack ",
    ),
    Key(
        [mod, "control"],
        "j",
        lazy.layout.shuffle_up(),
        desc="Move window up in current stack ",
    ),
    Key(["mod1"], "Tab", lazy.layout.next(), desc="Move focus to next window in group"),
    Key(
        ["mod1", "shift"],
        "Tab",
        lazy.layout.previous(),
        desc="Move focus to previous window in group",
    ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod], "r", lazy.spawn(rofi), desc="Launch Rofi"),
    Key(
        [mod],
        "p",
        lazy.spawn(f"{config_directory}/src/rofi-power.sh"),
        desc="Launch rofi power options",
    ),
    # Volume Control
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 0 -q set Master 2dB+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 0 -q set Master 2dB-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -D pulse set Master 1+ toggle")),
    Key([mod], "equal", lazy.spawn("amixer -c 0 -q set Master 2dB+")),
    Key([mod], "minus", lazy.spawn("amixer -c 0 -q set Master 2dB-")),
    # Window management
    Key([mod], "h", lazy.layout.shrink_main(), desc="Expand master (MonadTall)"),
    Key([mod], "l", lazy.layout.grow_main(), desc="Shrink master (MonadTall)"),
    Key(
        [mod, "shift"],
        "h",
        lazy.layout.swap_left(),
        desc="Move window to left (MonadTall)",
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.swap_right(),
        desc="Moce window to right (MonadTall)",
    ),
    Key([mod], "k", lazy.group["scratchpad"].dropdown_toggle("dropdown_terminal")),
    Key([mod], "Left", lazy.screen.prev_group(skip_managed=True)),
    Key([mod], "Right", lazy.screen.next_group(skip_managed=True)),
]

group_names = (
    ("web", {"layout": "max"}),
    ("dev", {"layout": "monadtall"}),
    ("term", {"layout": "monadtall"}),
    ("file", {"layout": "monadtall"}),
    ("chat", {"layout": "monadtall"}),
    ("misc", {"layout": "monadtall"}),
)

groups = [Group(name, **kwargs) for name, kwargs in group_names]

# Create a dropdown terminal
groups.append(
    ScratchPad(
        "scratchpad",
        [
            DropDown(
                "dropdown_terminal",
                f"{terminal} -T dropdown_terminal",
                on_focus_lost_hide=False,
                opacity=1,
                width=0.999,
                x=0.0005,
                height=0.55,
            ),
        ],
    ),
)

for i, (name, kwargs) in enumerate(group_names, 1):
    # Switch to another group
    keys.append(Key([mod], str(i), lazy.group[name].toscreen(toggle=False)))
    # Switch to last group
    keys.append(Key([mod], "Escape", lazy.screen.toggle_group()))
    # Send window to group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))

layout_theme = {
    "border_width": 2,
    "margin": 0,
    "single_border_width": 0,
    "border_focus": GREEN,
    "border_normal": BLACK,
}

layouts = [
    layout.Max(**layout_theme),
    # layout.Stack(**layout_theme, num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(**layout_theme),
    # layout.Columns(**layout_theme),
    # layout.Matrix(**layout_theme),
    layout.MonadTall(**layout_theme),
    # layout.MonadWide(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Tile(**layout_theme),
    # layout.TreeTab(**layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Zoomy(**layout_theme),
    layout.Floating(
        **layout_theme,
        float_rules=[
            # Run the utility of `xprop` to see the wm class and name of an X client.
            {"wmclass": "confirm"},
            {"wmclass": "dialog"},
            {"wmclass": "download"},
            {"wmclass": "error"},
            {"wmclass": "file_progress"},
            {"wmclass": "notification"},
            {"wmclass": "splash"},
            {"wmclass": "toolbar"},
            {"wmclass": "confirmreset"},  # gitk
            {"wmclass": "makebranch"},  # gitk
            {"wmclass": "maketag"},  # gitk
            {"wname": "branchdialog"},  # gitk
            {"wname": "pinentry"},  # GPG key password entry
            {"wmclass": "ssh-askpass"},  # ssh-askpass
        ],
    ),
]

widget_defaults = dict(
    font="Ubuntu",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    margin_y=3,
                    margin_x=0,
                    padding_y=5,
                    padding_x=3,
                    disable_drag=True,
                    active=BLUE,
                    inactive=WHITE,
                    rounded=False,
                    highlight_color=BLUE,
                    highlight_method="block",
                    this_current_screen_border=BLUE,
                    this_screen_border=GREEN,
                    block_highlight_text_color=BLACK,
                    other_current_screen_border=GREEN,
                    other_screen_border=BLACK,
                    urgent_alert_method="text",
                    urgent_text=RED,
                ),
                widget.Prompt(),
                widget.Spacer(),
                widget.Systray(),
                widget.Clock(format="%m/%d %a %I:%M"),
                widget.Sep(),
                widget.CPU(format="﬙ {load_percent}%"),
                widget.Sep(),
                widget.Memory(),
                widget.Volume(),
                widget.Battery(format="{char} {percent:2.0%}", notify_below=20),
                widget.CurrentLayoutIcon(scale=0.65),
            ],
            20,
        ),
        bottom=bar.Bar(
            [
                widget.TaskList(
                    borderwidth=0,
                    spacing=0,
                    highlight_method="block",
                    background=GREY,
                    border=BLACK,
                    markup_floating="<i>{}</i>",
                    markup_minimized="<s>{}</s>",
                    icon_size=0,
                    margin=0,
                    rounded=False,
                    title_width_method="uniform",
                ),
            ],
            18,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.toggle_floating()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"


@hook.subscribe.startup
def autostart():
    subprocess.call([f"{config_directory}/autostart.sh"])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
