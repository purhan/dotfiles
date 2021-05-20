.PHONY: all
all: debian

.PHONY: debian
debian: essentials others apt snap snap-classic

# Packages to be installed using apt
apt = 	firefox \
		chromium-browser \
		compton \
		rofi \
		vlc \
		peek \
		obs-studio \
		gnome-tweaks \
		htop \
		vim \
		neovim \
		awesome \
		i3lock-fancy \
		python3-pip \
		python3-venv \
		npm \
		nodejs \
		kitty \
		zsh \
		stow \
		arandr \
		xdotool \
		polkit-gnome-authentication-agent-1 \
		gh

# Packages to be installed as snaps
snap = discord

# Some snaps require confinement
snap-classic = 	sublime-text \
				code \
				postman


apt:
	sudo apt-get install $(apt)

snap:
	sudo snap install $(snap)

snap-classic:
	for package in $(snap-classic) ; do \
		sudo snap install $$package --classic ; \
	done

essentials:
	### INSTALLING ESSENTIAL PACKAGES ###
	# ================================= #
	sudo apt install \
	git \
	curl

others:
	### SETTING UP SHELLS ###
	# Install starship shell prompt
	curl -fsSL https://starship.rs/install.sh | bash

	# Install zsh plugins
	make -i -C ~/.config/zsh

	### SETTING UP AWESOME ###
	# ====================== #
	make -i -C ~/.config/requirements/awesome
