#!/bin/bash

# Ustawienia wstępne
set -e

sudo apt clean
sudo apt update && sudo apt upgrade -y

# Instalacja podstawowych narzędzi
sudo apt install -y wget curl git build-essential python3-pip

# Konfiguracja Python
cd /usr/lib/python3.11
sudo rm EXTERNALLY-MANAGED
cd
sudo apt install python3-venv -y

# Instalacja gnome-extensions-cli
pip3 install gnome-extensions-cli

tput reset && source ~/.profile

# Instalacja rozszerzeń GNOME
echo "Instalowanie rozszerzeń GNOME..."
gnome-extensions-cli install dash-to-dock@micxgx.gmail.com
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gnome-extensions-cli install 2087

# Pobieranie i ustawianie tła przez lokalnego użytkownika
echo "Pobieranie i ustawianie tła pulpitu..."
wget -O /home/osint/desktop2.png https://github.com/p4b1o/osint-template/raw/main/desktop2.png
gsettings set org.gnome.desktop.background picture-uri "file:///home/osint/desktop2.png"
gsettings set org.gnome.desktop.background picture-uri-dark "file:///home/osint/desktop2.png"
gsettings set org.gnome.desktop.background primary-color "rgb(0, 0, 0)"

# Konfiguracja GNOME przez lokalnego użytkownika
echo "Konfigurowanie GNOME..."
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant "dark"
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
gsettings set org.gnome.desktop.notifications show-banners false
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.mutter center-new-windows true

# Wyłączanie suspend przez lokalnego użytkownika
sudo systemctl mask suspend.target

# Instalacja Sherlock
echo "Instalowanie Sherlock..."
sudo apt install -y pipx
pipx install sherlock-project

# Instalacja Subfinder
echo "Instalowanie Subfinder..."
wget https://github.com/projectdiscovery/subfinder/releases/download/v2.5.7/subfinder_2.5.7_linux_amd64.zip -O /tmp/subfinder.zip
sudo unzip -o /tmp/subfinder.zip -d /usr/local/bin/
sudo rm /tmp/subfinder.zip

# Instalacja Tor Browser i OnionShare
echo "Instalowanie Tor Browser i OnionShare..."
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub org.torproject.torbrowser-launcher -y
flatpak run org.torproject.torbrowser-launcher
sudo flatpak install flathub org.onionshare.OnionShare -y

# Informacje końcowe
echo "Instalacja zakończona. Aby przełączyć na użytkownika osint, użyj polecenia: su - osint"
echo "Zainstalowane oprogramowanie: GNOME extensions, Sherlock, Subfinder."
