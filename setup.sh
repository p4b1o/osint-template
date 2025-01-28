#!/bin/bash

# Ustawienia wstępne
set -e

# Sprawdzanie, czy skrypt jest uruchamiany z uprawnieniami roota
if [ "$EUID" -ne 0 ]; then
    echo "Uruchom ten skrypt z uprawnieniami administratora (sudo)."
    exit 1
fi

# Aktualizacja systemu
#echo "Konfigurowanie apt dla Debian 12 (Bookworm)..."
#cat <<EOF > /etc/apt/sources.list
#deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
#deb-src http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
#deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
#deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
#deb http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware
#deb-src http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware
#deb http://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware
#deb-src http://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware
#EOF

apt clean
apt update && apt upgrade -y
echo "Aktualizowanie systemu..."
apt update && apt upgrade -y

# Instalacja wget i curl
echo "Instalowanie wget i curl..."
apt install -y wget curl
echo "Aktualizowanie systemu..."
apt update && apt upgrade -y

# Ustawienia terminala na tryb ciemny
echo "Konfigurowanie terminala na tryb ciemny..."
sudo -u osint gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'

# Pobieranie tła pulpitu
echo "Pobieranie tła pulpitu..."
wget -O /home/osint/desktop2.png https://github.com/p4b1o/osint-template/raw/main/desktop2.png

echo "Konfigurowanie terminala na tryb ciemny..."
sudo -u osint gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'

# Konfigurowanie docka na dolnej belce
sudo -u osint gsettings set org.gnome.desktop.background picture-uri "file:///home/osint/desktop2.png"
echo "Ustawianie tła pulpitu..."
wget -O /home/osint/desktop2.png https://github.com/p4b1o/osint-template/raw/main/desktop2.png
sudo -u osint gsettings set org.gnome.desktop.background picture-uri "file:///home/osint/desktop2.png"
# Konfigurowanie docka na dolnej belce
echo "Konfigurowanie docka na dolnej belce z dużymi ikonami..."
sudo -u osint gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
sudo -u osint gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
sudo -u osint gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 64
echo "Konfigurowanie terminala na tryb ciemny..."
sudo -u osint gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'
echo "Wyłączanie blokady ekranu i wygaszacza..."
sudo -u osint gsettings set org.gnome.desktop.session idle-delay 0
sudo -u osint gsettings set org.gnome.desktop.screensaver lock-enabled false

# Instalacja VMware Tools
echo "Instalowanie VMware Tools..."
apt install -y open-vm-tools open-vm-tools-desktop
systemctl restart vmtoolsd

# Instalacja Flatpak
echo "Instalowanie Flatpak..."
apt install -y flatpak
echo "Dodawanie Flatpak do GNOME Software..."
apt install -y gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


# Instalacja Firefox przez Flatpak
echo "Instalowanie Firefox przez Flatpak..."
flatpak install -y flathub org.mozilla.firefox

# Konfiguracja Firefox (instalacja wtyczek)
echo "Konfigurowanie Firefox (wtyczki)..."
firefox_profile_dir="$(find /home/osint/.mozilla/firefox -name "*.default-release" -type d | head -n 1)"
if [ -z "$firefox_profile_dir" ]; then
    echo "Nie znaleziono profilu Firefox. Pominięto instalację wtyczek."
else
    echo "Instalowanie wtyczek do Firefox..."
    cat <<EOF > "$firefox_profile_dir/extensions.json"
    {
        "addons": {
            "activeAddons": {
                "uBlockOrigin@raymondhill.net": {
                    "location": "app-profile",
                    "manifest": {
                        "name": "uBlock Origin"
                    }
                },
                "noscript@noscript.net": {
                    "location": "app-profile",
                    "manifest": {
                        "name": "NoScript"
                    }
                }
            }
        }
    }
EOF
fi

# Instalacja Sherlock
echo "Instalowanie Sherlock..."
apt install -y git python3-pip
sudo -u osint git clone https://github.com/sherlock-project/sherlock.git /home/osint/sherlock
sudo -u osint pip3 install -r /home/osint/sherlock/requirements.txt

# Instalacja Subfinder
echo "Instalowanie Subfinder..."
apt install -y unzip
wget https://github.com/projectdiscovery/subfinder/releases/download/v2.5.7/subfinder_2.5.7_linux_amd64.zip -O /tmp/subfinder.zip
unzip -o /tmp/subfinder.zip -d /usr/local/bin/
rm /tmp/subfinder.zip

# Instalacja ProtonVPN
echo "Instalowanie ProtonVPN..."
apt install -y openvpn dialog python3-pip
pip3 install protonvpn-cli

# Informacje końcowe
echo "Instalacja zakończona. Aby przełączyć na użytkownika osint, użyj polecenia: su - osint"
echo "Zainstalowane oprogramowanie: VMware Tools, Firefox, wtyczki, Sherlock, Subfinder, ProtonVPN."
