#!/bin/bash

echo "🔍 Abhängigkeiten werden geprüft..."

# Funktion zur Installation von zsh
install_zsh() {
  echo "❗️zshell nicht installiert, Installation wird ausgeführt..."

  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    if command -v brew >/dev/null 2>&1; then
      brew install zsh
    else
      echo "❌ Homebrew nicht gefunden. Bitte installiere es manuell: https://brew.sh"
      exit 1
    fi
  elif [[ -f /etc/debian_version ]]; then
    # Debian/Ubuntu
    sudo apt update && sudo apt install -y zsh
  elif [[ -f /etc/redhat-release ]]; then
    # RHEL/CentOS/Fedora
    sudo dnf install -y zsh || sudo yum install -y zsh
  else
    echo "❌ Nicht unterstütztes System. Bitte installiere zsh manuell."
    exit 1
  fi
}

# Prüfen, ob zsh installiert ist
if ! command -v zsh >/dev/null 2>&1; then
  install_zsh
  if [ $? -ne 0 ]; then
    echo "❌ zshell Installation fehlgeschlagen."
    exit 1
  fi
else
  echo "✅ zshell ist bereits installiert."
fi

# Zsh als Standard-Shell setzen, falls nicht bereits gesetzt
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
  echo "⚙️ zshell als Standard-Shell gesetzt. Bitte Terminal neu starten."
fi

echo "✅ Installation erfolgreich."

echo "Starting Setup"

# Alacritty Config
mkdir -p ~/.config/alacritty/
mkdir -p ~/.config/alacritty/themes/

cp ./alacritty.toml ~/.config/alacritty/alacritty.toml
cp ./alacritty.toml ~/.config/alacritty/themes/tokyo-night.toml

# ZSH Config
cp ./.zshrc ~/.zshrc
cp ./.p10k.zsh ~/.p10k.zsh

echo "Setup finished"
