#!/bin/bash

# Ustawienia wstępne
set -e

# Sprawdzanie, czy skrypt jest uruchamiany z uprawnieniami roota
if [ "$EUID" -ne 0 ]; then
    echo "Uruchom ten skrypt z uprawnieniami administratora (sudo)."
    exit 1
fi

apt clean
apt update && apt upgrade -y

# Instalacja podstawowych narzędzi
apt install -y wget curl git build-essential python3-pip

# Instalacja gnome-extensions-cli
pip3 install gnome-extensions-cli

tput reset && source ~/.profile

# Instalacja rozszerzeń GNOME
echo "Instalowanie rozszerzeń GNOME..."
gnome-extensions-cli install dash-to-dock@micxgx.gmail.com
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gnome-extensions-cli install 2087

# Konfiguracja GNOME
echo "Konfigurowanie GNOME..."
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
gsettings set org.gnome.desktop.background picture-uri ''
gsettings set org.gnome.desktop.background picture-uri-dark ''
gsettings set org.gnome.desktop.background primary-color 'rgb(30, 6, 5)'
gsettings set org.gnome.desktop.notifications show-banners false
gsettings set org.gnome.desktop.session idle-delay 0
sudo systemctl mask suspend.target
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.mutter center-new-windows true

# Instalacja Sherlock
echo "Instalowanie Sherlock..."
sudo -u osint git clone https://github.com/sherlock-project/sherlock.git /home/osint/sherlock
sudo -u osint pip3 install -r /home/osint/sherlock/requirements.txt

# Instalacja Subfinder
echo "Instalowanie Subfinder..."
wget https://github.com/projectdiscovery/subfinder/releases/download/v2.5.7/subfinder_2.5.7_linux_amd64.zip -O /tmp/subfinder.zip
unzip -o /tmp/subfinder.zip -d /usr/local/bin/
rm /tmp/subfinder.zip

# Instalacja ProtonVPN
echo "Instalowanie ProtonVPN..."
pip3 install protonvpn-cli

# Informacje końcowe
echo "Instalacja zakończona. Aby przełączyć na użytkownika osint, użyj polecenia: su - osint"
echo "Zainstalowane oprogramowanie: GNOME extensions, Sherlock, Subfinder, ProtonVPN."
