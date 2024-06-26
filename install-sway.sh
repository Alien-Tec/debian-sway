#!/bin/sh

cd ~/

### Sway packages
sudo apt install -y sway waybar swaylock swayidle swaybg
sudo apt install -y gvfs-backends

### File manager (thunar)
sudo apt install -y thunar thunar-archive-plugin thunar-volman file-roller

### Terminal
sudo apt install -y alacritty

###
sudo apt install -y mtools dosfstools acpi acpid avahi-daemon
sudo systemctl enable acpid
sudo systemctl enable avahi-daemon

### Polkit
# sudo apt install -y policykit-1-gnome # (doesn't work on wayland; @debian)
sudo apt install -y polkit-kde-agent-1

### Network Manager
sudo apt install -y network-manager network-manager-gnome 

### Volume and brightness utilities
sudo apt install -y light pamixer

### Sound packages
sudo apt install -y pulseaudio alsa-utils pavucontrol volumeicon-alsa pulsemixer

### Launcher and notification daemon
sudo apt install -y wofi sway-notification-center wob libnotify-bin suckless-tools vim
### Bisa juga pakai mako-notifier tapi swaync lebih better

### Clipboard manager
sudo apt install -y  clipman

### Redshift replacement for wayland
sudo apt install -y wlsunset

### Screenshot stuff

sudo apt install -y grim grimshot slurp imagemagick zenity wl-clipboard

# Build wl-color-picker
[ ! -d "~/.stuff/" ] && mkdir -p ~/.stuff && cd ~/.stuff
git clone https://github.com/jgmdev/wl-color-picker
cd wl-color-picker
sudo make install

# Build swappy
sudo apt install -y meson ninja-build libcairo2-dev pango1.0-tools libgtk-3-dev libglib2.0-0 scdoc
[ ! -d "~/.stuff/" ] && mkdir -p ~/.stuff && cd ~/.stuff
git clone https://github.com/jtheoof/swappy.git
cd swappy
meson setup build
ninja -C build
sudo cp build/swappy /usr/local/bin
cd ~/

# Build nwg-look
sudo apt install -y golang
sudo apt install -y libglib2.0-dev
sudo apt install -y libcairo2-dev
sudo apt install -y libwebkit2gtk-4.0-dev
# sudo apt install -y libcairo-gobject2 # sudah include sama yg atas?
git clone https://github.com/nwg-piotr/nwg-look
cd nwg-look
make build # (take long time)
sudo make install

# Build SwayOSD (testing, failed, use wob)
# sudo apt install -y sassc libudev-dev
# git clone https://github.com/ErikReider/SwayOSD
# cd SwayOSD
# # Please note that the command below might require `--prefix /usr` on some systems
# meson setup build
# ninja -C build
# meson install -C build

sudo apt install -y wf-recorder

sudo apt install -y wayland-protocols xwayland 
sudo apt install -y libgtk-layer-shell-dev # ?
sudo apt install -y xdg-desktop-portal-wlr
sudo apt install -y dex jq 
sudo apt install -y geany 
sudo apt install -y build-essential 
sudo apt install -y libpam0g-dev libxcb1-dev
xdg-user-dirs-update

### Microcode for Intel/AMD 
sudo apt install -y amd64-microcode
# sudo apt install -y intel-microcode 

#### For GTK setting
#### using gsettings command
sudo apt install -y libglib2.0-bin

### it will also install adwaita icon
sudo apt install -y arc-theme

### PDF viewer
sudo apt install -y mupdf zathura

### Image viewer
sudo apt install -y mirage nsxiv

### Music/media player packages
sudo apt install -y mpc mpd ncmpcpp mpv

### firefox dependencies (build instruction at the on of this script)
sudo apt install -y libdbus-glib-1-2

### Tmux and plugins
sudo apt install -y tmux 
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

### Application on keybindings
sudo apt install -y galculator trash-cli calcurse

### Fonts and icons for now
sudo apt install -y fonts-firacode fonts-liberation2
sudo apt install -y fonts-noto-color-emoji fonts-font-awesome

### Printing and bluetooth (if needed)
sudo apt install -y cups system-config-printer simple-scan
sudo apt install -y bluez blueman

sudo systemctl enable cups
sudo systemctl enable bluetooth

### Neofetch/HTOP
sudo apt install -y neofetch htop

## Install zsh and copy all config
sudo apt install -y zsh fzf bc
[ ! -d "~/.local/src/zsh_plugins/" ] && mkdir -p ~/.local/src/zsh_plugins
cd ~/.local/src/zsh_plugins/
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/hlissner/zsh-autopair.git

### Copy config
cp -r ~/.dotfiles/.config/* ~/.config
# of 'symlink' it

cd ~/
cp -r ~/.dotfiles/.local/bin/ ~/.local/
[ ! -d "~/.local/share/" ] && mkdir -p ~/.local/share
cp -r ~/.dotfiles/.local/share/* ~/.local/share/
ln -s ~/.config/zsh/profile .zprofile
chsh -s $(which zsh) # change default shell

# Create thunar config to have 'open terminal here':
[ ! -d "~/.config/xfce4/" ] && mkdir -p ~/.config/xfce4
echo "TerminalEmulator=alacritty" > ~/.config/xfce4/helpers.rc
echo "TerminalEmulatorDismissed=true" >> ~/.config/xfce4/helpers.rc
# Thunar - edit - configure custom actions
# on 'open terminal here' - create keyboard shortcut (ex: F4)

# Install icon and theme
sudo tar -xf ~/.dotfiles/.assets/qogir-icon.tar.gz -C /usr/share/icons
sudo tar -xf ~/.dotfiles/.assets/tela-blue-icon.tar.gz -C /usr/share/icons

# Custom GRUB theme
# this is just add new file, not to worry
sudo cp ~/.dotfiles/.assets/99_mytheme /etc/grub.d
sudo update-grub

sudo apt autoremove

printf "\e[1;32m* All config file are copied\e[0m\n"
printf "\e[1;32m* To build neovim, firefox, etc. Read the instructions in this script\e[0m\n"
printf "\e[1;32m* Don't forget to source tmux plugin in terminal\e[0m\n"
printf "\e[1;32m* Icon and theme was set in sway config\e[0m\n"
printf "\e[1;32m* Just note if you want to change it,\e[0m\n\n"
printf "\e[1;32mYou can now reboot! after login in tty1, it will auto start SWAY session. Thanks you.\e[0m\n"

##############################
###### Another packages ######
##############################

### Neovim (Recomended) 
## Build neovim from source:
## https://github.com/neovim/neovim/wiki/Building-Neovim
# sudo apt-get install -y ninja-build gettext cmake unzip curl
# cd ~/.stuff
# git clone https://github.com/neovim/neovim
# cd neovim
# git checkout stable
# make CMAKE_BUILD_TYPE=RelWithDebInfo
# sudo make install

### Nodejs (require for neovim config)
# Download binary file, and put the directory into ~/.local/src/
# ex: ~/.local/src/node-v18.16.1-linux-x64/*
# And source it in zsh profile

### Firefox (binary)
## Build firefox:
# sudo apt install -y libdbus-glib-1-2 # require dependencies
# download firefox*.tar.bz2: wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/115.0.2/linux-x86_64/en-US/firefox-115.0.2.tar.bz2
# if link not working (version changed), download from: https://support.mozilla.org/en-US/kb/install-firefox-linux
# step:
# - download source code from official website
# - extract the file: tar xjf firefox-*.tar.bz2
# - mv firefox /opt
# - ln -s /opt/firefox/firefox /usr/local/bin/firefox
# - download .desktop file: wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop
# - sudo mv firefox.desktop /usr/share/applications/
# done....

### OBS Studio (if needed)
# sudo apt install -y qt6-wayland
# sudo apt install -y linux-headers-6.1.0-10-amd64 v4l2loopback-dkms
# sudo apt install -y obs-studio
# sudo modprobe v4l2loopback devices=1 video_nr=10 card_label="OBS Camera" exclusive_caps=1

### Microsoft font | msfont
# sudo apt install software-properties-common -y
# sudo apt-add-repository contrib non-free -y
# sudo apt install ttf-mscorefonts-installer
# sudo fc-cache -fv

### Samba
# sudo apt install -y samba smbclient cifs-utils
# sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
#
##Method 1) Using existing user (currently used)
# mkdir -p /home/agung/shares/{public_files,protected_files}
#
##Method 2) Create new smbgroup and smbuser
# sudo mkdir -p /share/{public_files,protected_files}
# sudo groupadd --system smbgroup
# sudo useradd --system --no-create-home --group smbgroup -s /bin/false smbuser
# sudo chown -R smbuser:smbgroup /shares
# 
## Create config file:
# sudo nvim /etc/samba/smb.conf
#
# Remove comment based on method you are using
#
#############^ smb.conf ^#############
#[global]
#server string = File Server
#workgroup = WORKGROUP
#security = user
#map to guest = Bad User
#name resolve order = bcast host

#[Public Files]
##path = /shares/public_files
##path = /home/agung/shares/public_files
##force user = smbuser
##force group = smbgroup
##force user = agung
##force group = agung
#create mask = 0664
#force create mode = 0664
#directory mask = 0775
#force directory mode = -775
#public = yes
#writable = yes

#[Protected Files]
##path = /shares/protected_files
##path = /home/agung/shares/protected_files
##force user = smbuser
##force group = smbgroup
##force user = agung
##force group = agung
#create mask = 0664
#force create mode = 0664
#directory mask = 0775
#force directory mode = -775
#public = yes
#writable = no
#############_ smb.conf _#############
#
# sudo systemctl restart smbd
