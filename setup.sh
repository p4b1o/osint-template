#!/bin/bash

###############################################################################
# AKTUALIZACJA I CZYSZCZENIE
###############################################################################
sudo apt clean
sudo apt update && sudo apt upgrade -y

###############################################################################
# INSTALACJA PODSTAWOWYCH NARZĘDZI
###############################################################################
sudo apt install -y wget curl git build-essential python3-pip flatpak unzip

###############################################################################
# KONFIGURACJA PYTHONA
###############################################################################
cd /usr/lib/python3.11
sudo rm EXTERNALLY-MANAGED
cd
sudo apt install -y python3-venv

###############################################################################
# INSTALACJA I KONFIGURACJA pipx
###############################################################################
sudo apt install -y pipx
###############################################################################
# INSTALACJA GNOME-EXTENSIONS-CLI
###############################################################################
pipx install gnome-extensions-cli
tput reset && source ~/.profile

###############################################################################
# INSTALACJA I KONFIGURACJA ROZSZERZEŃ GNOME
###############################################################################
echo "Instalowanie rozszerzeń GNOME..."
gnome-extensions-cli install dash-to-dock@micxgx.gmail.com
gnome-extensions enable dash-to-dock@micxgx.gmail.com
echo "Konfigurowanie docka GNOME..."
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock autohide false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock autohide-in-fullscreen false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock intellihide false
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 64
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock dock-fixed true
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock extend-height false

# Instalacja rozszerzenia 2087
gnome-extensions-cli install 2087

###############################################################################
# TŁO PULPITU
###############################################################################
echo "Pobieranie i ustawianie tła pulpitu..."
wget -O /home/osint/desktop2.png \
  https://github.com/p4b1o/osint-template/raw/main/desktop.png

gsettings set org.gnome.desktop.background picture-uri \
  "file:///home/osint/desktop2.png"
gsettings set org.gnome.desktop.background picture-uri-dark \
  "file:///home/osint/desktop2.png"
gsettings set org.gnome.desktop.background primary-color "rgb(0, 0, 0)"


###############################################################################
# Reszta ustawień
###############################################################################
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.notifications show-banners false
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'

###############################################################################
# WYŁĄCZANIE SUSPEND
###############################################################################
sudo systemctl mask suspend.target

###############################################################################
# INSTALACJA SHERLOCK, GHUNT, THEHARVESTER, EXIFTOOL (PRZEZ PIPX)
###############################################################################
pipx install sherlock-project
pipx install ghunt
pipx install theHarvester
pipx install exiftool
pipx install h8mail
pipx install search-that-hash
pipx install name-that-hash
tput reset && source ~/.profile

###############################################################################
# INSTALACJA SUBFINDER
###############################################################################
echo "Instalowanie Subfinder..."
wget \
  https://github.com/projectdiscovery/subfinder/releases/download/v2.5.7/subfinder_2.5.7_linux_amd64.zip \
  -O /tmp/subfinder.zip
sudo unzip -o /tmp/subfinder.zip -d /usr/local/bin/
sudo rm /tmp/subfinder.zip

###############################################################################
# INSTALACJA TOR BROWSER (flatpak) + ONIONSHARE
###############################################################################
echo "Instalowanie Tor Browser i OnionShare..."
sudo flatpak remote-add --if-not-exists flathub \
  https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub org.torproject.torbrowser-launcher -y

# Uruchomienie konfiguratora Tor Browser (opcjonalne)
flatpak run org.torproject.torbrowser-launcher

###############################################################################
# REINSTALACJA FIREFOX-ESR (z BACKPORTS)
###############################################################################
sudo apt remove --purge firefox-esr -y
echo "deb http://deb.debian.org/debian/ bookworm-backports main" \
  | sudo tee /etc/apt/sources.list.d/debian-backports.list
sudo apt update
sudo apt -t bookworm-backports install firefox-esr -y
###############################################################################
# INSTALACJA VISUAL STUDIO CODE
###############################################################################
mkdir ~/Programy
cd ~/Programy
git clone https://github.com/C3n7ral051nt4g3ncy/WhatsMyName-Python.git
cd WhatsMyName-Python
python3 -m venv WhatsMyName-Python-venv
source WhatsMyName-Python-venv/bin/activate
sudo pip3 install -r requirements.txt
deactivate
###############################################################################
# INSTALACJA VISUAL STUDIO CODE
###############################################################################
echo "Instalowanie Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/packages.microsoft.gpg > /dev/null

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] \
  https://packages.microsoft.com/repos/code stable main" \
  | sudo tee /etc/apt/sources.list.d/vscode.list

sudo apt update && sudo apt install -y code

###############################################################################
# SZABLON FIREFOX
###############################################################################
cd ~/
wget -O mozilla.tgz https://pawelhordynski.com/osint/mozilla.tgz
tar -xzvf mozilla.tgz
rm mozilla.tgz

###############################################################################
# USTAWIENIE ULUBIONYCH APLIKACJI W GNOME-SHELL
###############################################################################
gsettings set org.gnome.shell favorite-apps []
gsettings set org.gnome.shell favorite-apps \
 "['firefox-esr.desktop','org.gnome.Nautilus.desktop','org.gnome.Terminal.desktop','code.desktop','org.torproject.torbrowser-launcher.desktop']"
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32

###############################################################################
# REBOOT
###############################################################################
echo "Skript ukończony. System uruchomi się ponownie..."
sudo reboot
