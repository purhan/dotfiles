# Gallery

### Awesome

|Lucid|Werewolf|Redhound|
|-|-|-|
|![Lucid](https://gist.githubusercontent.com/Purhan/56da0def1de841ec07b65137f8cd587c/raw/8e0942bcd9bc35ab4af169dbce51bc9de80c2949/lucid.png)|![Werewolf](https://gist.githubusercontent.com/Purhan/56da0def1de841ec07b65137f8cd587c/raw/8e0942bcd9bc35ab4af169dbce51bc9de80c2949/werewolf.png)|![Redhound](https://gist.githubusercontent.com/Purhan/56da0def1de841ec07b65137f8cd587c/raw/8e0942bcd9bc35ab4af169dbce51bc9de80c2949/redhound.png)|

# Usage

First, clone this repository:
Since I use the same repository to host a number of things across different
branches, it can become quite large. Download only the relevant branch:

```bash
git clone -b old --single-branch --depth=1 https://github.com/purhan/dotfiles
```

Select your favourite window manager and follow the guide for it given below.

### Awesome

- Install the following packages:
    - [Awesome window manager](https://github.com/awesomeWM/awesome) (Required):
        The window manager itself.
    - [Picom/Compton](https://github.com/yshui/picom) (Optional): A compositor to
        avoid screen tearing.
    - [Nitrogen](https://github.com/l3ib/nitrogen) (Optional): To setup the wallpaper
    - [Rofi](https://github.com/davatorium/rofi) (Optional): A Dmenu replacement (to
        launch your applications).

- Create a backup of your old configuration (if it exists).

- Choose your favourite setup from the [gallery](#gallery). Copy the contents
    of `$REPO/src/.config/awesome/<setup-name>/` to your config directory (`~/.config/awesome/`)

- Go through `~/.config/awesome/configuration/apps.lua` and replace the default apps
    with the ones you use.

- Go through `~/.config/awesome/theme/` and replace the fonts with your favourite ones, or
    install the ones already listed.

- [Optional] Copy `$REPO/src/.config/compton.conf` and `$REPO/src/.config/rofi/` to your
    `~/.config` directory.

- [Optional] Launch `nitrogen` and select your favourite wallpaper. The configurations run
    `nitrogen --restore` to setup the wallpaper on startup.
