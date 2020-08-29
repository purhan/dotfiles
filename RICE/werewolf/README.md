## AwesomeWM Rice :)

![](https://raw.githubusercontent.com/Purhan/dotfiles/master/RICE/werewolf/Screenshot.png)

You're probably here from reddit...

Let's get straight to the point.

## Installation

### 1) Clone the configuration

Run the following commands in the terminal. This also creates a backup for any pre-existing configuration.

```bash

git clone --depth 1 https://github.com/purhan/dotfiles.git
cp ~/.config/awesome ~/.config/awesome_backup
mv -a dotfiles/RICE/werewolf/. ~/.config/awesome
rm -rf dotfiles

```

### 2) Install the dependencies

#### ON ARCH:

Just run the following commands:

```bash
cd ~/.config/awesome
make
#  if yay is not found, do:
#  sudo pacman -S yay
```

The makefile contains all the dependencies. If anything breaks, you can either change the makefile or install the packages manually (from your package manager).

#### ON DEBIAN / OTHERS:

Install the following dependencies

- [AwesomeWM](https://awesomewm.org/) as the window manager

- [Roboto](https://fonts.google.com/specimen/Roboto) as the **font**

- [Rofi](https://github.com/DaveDavenport/rofi) for the app launcher

- [Compton fork](https://github.com/tryone144/compton) for the compositor (blur and animations)

- [i3lock-fancy](https://github.com/meskarune/i3lock-fancy) the lockscreen application

- [xclip](https://github.com/astrand/xclip) for copying screenshots to clipboard

- **gnome-keyring-daemon** and a **policykit-agent**

- (Optional) **qt5-styles-gtk2** or **qt5-styles-plugins** for making QT and KDE applications look the same as gnome applications

- (Optional) [Dracula](https://draculatheme.com/gtk) as GTK theme

- (Optional) [Papirus Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) as icon theme

- (Optional) [lxappearance](https://sourceforge.net/projects/lxde/files/LXAppearance/) to set up the gtk and icon theme

- (Optional) [xbacklight](https://www.x.org/archive/X11R7.5/doc/man/man1/xbacklight.1.html) for adjusting brightness on laptops (disabled by default)

- (Optional) [kde-spectacle](https://kde.org/applications/utilities/org.kde.spectacle) my personal screenshot utility of choice, can be replaced by whichever you want, just remember to edit the screenshot utility script

### 3) Set the themes

Start **lxappearance** to active the **icon** theme and **GTK** theme

### 4) Same theme for Qt/KDE applications and GTK applications, and fix missing indicators

First install `qt5-style-plugins` (or `qt5-style-gtk2`) and add this to the bottom of your `/etc/environment`

```bash

XDG_CURRENT_DESKTOP=Unity

QT_QPA_PLATFORMTHEME=gtk2

```

The first variable fixes most indicators (especially electron based ones!), the second tells Qt and KDE applications to use your gtk2 theme set through lxappearance.

- **Wallpaper**: [Pier Sunset](https://www.deviantart.com/danil-laning/art/Pier-sunset-849636122) by [Danil Laning](https://www.deviantart.com/danil-laning)

- **GTK**: [Dracula](https://draculatheme.com/gtk)

- **Icons**: [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)

- **Shell Script (ASCII)**: [vampire.sh](https://raw.githubusercontent.com/Purhan/dotfiles/master/RICE/werewolf/vampire.sh)
