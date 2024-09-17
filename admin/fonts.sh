#!/bin/bash

fonts=(
    "ttf-spacemono"
    "ttf-jetbrains-mono"
    "ttf-jetbrains-mono-nerd"
    "ttf-iosevka-nerd"
    "ttf-iosevka"
    "ttf-miracode"
    "ttf-google-fonts-git"
    "ttf-mononoki"
    "ttf-poppins"
    "otf-monaspace-nerd"
    "ttf-arphic-uming"
    "ttf-indic-otf"
    "ttf-twemoji"
)

if ! command -v yay &> /dev/null; then
    echo "error: yay is not installed, please install yay first"
    exit 1
fi

for font in "${fonts[@]}"; do
    echo "Installing $font..."
    yay -S --noconfirm "$font"
done

echo "all fonts have been installed successfully"