#!/bin/bash
echo "Starting Setup"

# Alacritty Config
mkdir -p ~/.config/alacritty/
mkdir -p ~/.config/alacritty/themes/

cp ./alacritty.toml ~/.config/alacritty/alacritty.toml
cp ./alacritty.toml ~/.config/alacritty/themes/tokyo-night-alacritty-theme/

# ZSH Config
cp ./.zshrc ~/.zshrc
cp ./.p10k.zsh ~/.p10k.zsh

echo "Setup finished"
