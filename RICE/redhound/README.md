
## AwesomeWM Rice :)

![](https://i.redd.it/ck8zw9ypzph51.png)
You're probably here from reddit...
Let's get straight to the point.

## Installation
### 1) Install the dependencies
- [AwesomeWM](https://awesomewm.org/) as the window manager
- [Roboto](https://fonts.google.com/specimen/Roboto) as the **font**
- [Rofi](https://github.com/DaveDavenport/rofi) for the app launcher
- [Compton fork](https://github.com/tryone144/compton) for the compositor (blur and animations)
- [i3lock-fancy](https://github.com/meskarune/i3lock-fancy) the lockscreen application
- [xclip](https://github.com/astrand/xclip) for copying screenshots to clipboard
- __gnome-keyring-daemon__ and a __policykit-agent__ (by default policykit-1-gnome is enabled)
- (Optional) __qt5-styles-gtk2__ or __qt5-styles-plugins__ for making QT and KDE applications look the same as gnome applications
- (Optional) [Materia](https://github.com/nana-4/materia-theme) as GTK theme
- (Optional) [Papirus Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) as icon theme
- (Optional) [lxappearance](https://sourceforge.net/projects/lxde/files/LXAppearance/) to set up the gtk and icon theme
- (Optional) [xbacklight](https://www.x.org/archive/X11R7.5/doc/man/man1/xbacklight.1.html) for adjusting brightness on laptops (disabled by default)
- (Optional) [kde-spectacle](https://kde.org/applications/utilities/org.kde.spectacle) my personal screenshot utility of choice, can be replaced by whichever you want, just remember to edit the screenshot utility script

### 2) Clone the configuration
Run the following commands in the terminal. This also creates a backup for any pre-existing configuration.
```
git clone https://github.com/purhan/dotfiles.git
cp ~/.config/awesome ~/.config/awesome_backup
mv -a dotfiles/RICE/redhound/. ~/.config/awesome
rm -rf dotfiles
```

### 3) Set the themes
Start **lxappearance** to active the **icon** theme and **GTK** theme
Note: for cursor theme, edit `~/.icons/default/index.theme` and `~/.config/gtk3-0/settings.ini`, for the change to also show up in applications run as root, copy the 2 files over to their respective place in `/root`.

### 4) Same theme for Qt/KDE applications and GTK applications, and fix missing indicators
First install `qt5-style-plugins` (or `qt5-style-gtk2`) and add this to the bottom of your `/etc/environment`

```bash
XDG_CURRENT_DESKTOP=Unity
QT_QPA_PLATFORMTHEME=gtk2
```

The first variable fixes most indicators (especially electron based ones!), the second tells Qt and KDE applications to use your gtk2 theme set through lxappearance.

* **Credits** The original [fork](https://github.com/HikariKnight/material-awesome)
* **Wallpaper**: [Quiet Household](https://www.behance.net/gallery/80472545/Your-Home?tracking_source=search_projects_recommended%7Cmountain%20house%20wallpaper) by [Sergey Bolsun](https://www.behance.net/bolsun)
* **GTK**: [Numix-Dark](https://github.com/numixproject/numix-gtk-theme-dark)
* **Icons**: [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
