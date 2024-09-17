#!/bin/bash

pkg() {
    if pacman -Qi "$1" &> /dev/null; then
        echo "$1 is already installed"
    elif pacman -Si "$1" &> /dev/null; then
        sudo pacman -S --noconfirm "$1"
    else
        yay -S --noconfirm "$1"
    fi
}

if [ "$EUID" -eq 0 ]; then
    echo "Please do not run this script as root"
    exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

pkg "code"
echo "Copying dotfiles..."
mkdir -p ~/.config
cp -r "$SCRIPT_DIR/dunst" ~/.config/
cp -r "$SCRIPT_DIR/fish" ~/.config/
cp -r "$SCRIPT_DIR/i3" ~/.config/
cp -r "$SCRIPT_DIR/kitty" ~/.config/
cp -r "$SCRIPT_DIR/polybar" ~/.config/
cp -r "$SCRIPT_DIR/rofi" ~/.config/
cp -r "$SCRIPT_DIR/micro" ~/.config/
cp "$SCRIPT_DIR/starship.toml" ~/.config/

packages=(
    "rofi"
    "starship"
    "playerctl"
    "rustup"
    "xterm"
    "flameshot"
    "discord"
    "feh"
    "xsel"
    "xclip"
    "catppuccin-cursors-mocha"
)

for package in "${packages[@]}"; do
    pkg "$package"
done

echo "Creating Xresources file..."
cat << EOF > ~/.Xresources
Xft.dpi: 192
Xcursor.theme: catppuccin-mocha-mauve-cursors
EOF

xrdb ~/.Xresources

if [ -f "$SCRIPT_DIR/admin/installvsc.sh" ]; then
    echo "Installing VSCode extensions..."
    bash "$SCRIPT_DIR/admin/installvsc.sh"
else
    echo "Warning: VSCode extension installation script not found"
fi

if [ -f "$SCRIPT_DIR/admin/fonts.sh" ]; then
    echo "Installing fonts..."
    bash "$SCRIPT_DIR/admin/fonts.sh"
else
    echo "Warning: Fonts installation script not found"
fi

echo "Installation complete!"