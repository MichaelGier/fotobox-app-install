#!/bin/bash
# photobooth-install.sh
# Einfache Installation von Photobooth-App auf Raspberry Pi

set -e  # Skript bei Fehlern abbrechen

echo "=== Update und Upgrade des Systems ==="
sudo apt update
sudo apt upgrade -y

echo "=== Installation der benötigten Pakete ==="
sudo apt -y install ffmpeg libturbojpeg0 libgl1 libgphoto2-dev fonts-noto-color-emoji
sudo apt -y install libexif12 libgphoto2-6 libgphoto2-port12 libltdl7
sudo apt -y install libvips
sudo apt -y install pipx
sudo apt -y install gphoto2

echo "=== Konfiguration von pipx ==="
pipx ensurepath

echo "=== Installation von photobooth-app über pipx ==="
pipx install --system-site-packages photobooth-app --pip-args='--prefer-binary'

echo "=== Anlegen des Datenordners ==="
mkdir -p ~/photobooth-data

echo "=== Entfernen störender Prozesse ==="
killall gvfs-gphoto2-volume-monitor || true
sudo apt remove -y gvfs-backends

echo "=== Hinzufügen des Nutzers zur plugdev-Gruppe ==="
sudo usermod -a -G plugdev $USER

echo "=== Installation abgeschlossen! Der Raspberry Pi wird nun neu gestartet... ==="
sudo reboot
