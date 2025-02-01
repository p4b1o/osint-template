#!/bin/bash

###############################################################################
# USTAWIENIA WSTĘPNE
###############################################################################
set +e

# Aktualizacja i czyszczenie pakietów
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
# INSTALACJA GNOME-EXTENSIONS-CLI
###############################################################################
pip3 install gnome-extensions-cli

###############################################################################
# INSTALACJA I KONFIGURACJA ROZSZERZEŃ GNOME
###############################################################################
echo "Instalowanie rozszerzeń GNOME..."
# Najpierw instalujemy, później włączamy
gnome-extensions-cli install dash-to-dock@micxgx.gmail.com
gnome-extensions enable dash-to-dock@micxgx.gmail.com

# Drugi przykład instalacji wg ID (ID: 2087)
gnome-extensions-cli install 2087

echo "Konfigurowanie docka GNOME..."
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 48
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false

# Odświeżenie profilu
tput reset && source ~/.profile

###############################################################################
# USTAWIANIE TŁA PULPITU
###############################################################################
echo "Pobieranie i ustawianie tła pulpitu..."
wget -O /home/osint/desktop2.png \
  https://github.com/p4b1o/osint-template/raw/main/desktop2.png

gsettings set org.gnome.desktop.background picture-uri \
  "file:///home/osint/desktop2.png"
gsettings set org.gnome.desktop.background picture-uri-dark \
  "file:///home/osint/desktop2.png"
gsettings set org.gnome.desktop.background primary-color "rgb(0, 0, 0)"

###############################################################################
# KONFIGURACJA GNOME
###############################################################################
echo "Konfigurowanie GNOME..."
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant "dark"
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
gsettings set org.gnome.desktop.notifications show-banners false
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.mutter center-new-windows true

###############################################################################
# WYŁĄCZANIE SUSPEND
###############################################################################
sudo systemctl mask suspend.target

###############################################################################
# INSTALACJA SHERLOCK, GHUNT, THEHARVESTER, EXIFTOOL (PRZEZ PIPX)
###############################################################################
sudo apt install -y pipx
pipx install sherlock-project
pipx install ghunt
pipx install theHarvester

# EXIFTOOL przez pipx – w razie problemów można zainstalować natywnie z apt
pipx install exiftool

pipx ensurepath

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

# Opcjonalne uruchomienie konfiguratora
flatpak run org.torproject.torbrowser-launcher

###############################################################################
# REINSTALACJA FIREFOX-ESR (z backports)
###############################################################################
sudo apt remove --purge firefox-esr -y
echo "deb http://deb.debian.org/debian/ bookworm-backports main" \
  | sudo tee /etc/apt/sources.list.d/debian-backports.list
sudo apt update
sudo apt -t bookworm-backports install firefox-esr -y

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
gsettings set org.gnome.shell favorite-apps \
 "['firefox-esr.desktop','org.gnome.Nautilus.desktop','org.gnome.Terminal.desktop','code.desktop','org.torproject.torbrowser-launcher.desktop']"

###############################################################################
# REBOOT
###############################################################################
echo "Skript ukończony. System uruchomi się ponownie..."
sudo reboot
