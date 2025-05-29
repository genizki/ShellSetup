#!/bin/bash

set -e

echo "🔍 Abhängigkeiten werden geprüft..."

# Plattform erkennen
if [[ "$OSTYPE" == "darwin"* ]]; then
  PLATFORM="macos"
elif [[ -f /etc/debian_version ]]; then
  PLATFORM="debian"
elif [[ -f /etc/redhat-release ]]; then
  PLATFORM="fedora"
else
  echo "❌ Nicht unterstütztes System."
  exit 1
fi

# ----------------------------
# Zsh installieren
# ----------------------------
install_zsh() {
  echo "❗️zshell nicht installiert, Installation wird ausgeführt..."
  case "$PLATFORM" in
  macos)
    if command -v brew >/dev/null 2>&1; then
      brew install zsh
    else
      echo "❌ Homebrew nicht gefunden. Bitte installiere es manuell: https://brew.sh"
      exit 1
    fi
    ;;
  debian)
    sudo apt update && sudo apt install -y zsh
    ;;
  fedora)
    sudo dnf install -y zsh || sudo yum install -y zsh
    ;;
  esac
}

# ----------------------------
# Powerlevel10k installieren
# ----------------------------
install_powerlevel10k() {
  echo "📦 Powerlevel10k wird installiert..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
}

# ----------------------------
# Nerd Fonts installieren
# ----------------------------

install_fonts() {
  echo "🔤 0xProto Nerd Font wird installiert..."

  case "$PLATFORM" in
  macos)
    brew tap homebrew/cask-fonts
    brew install --cask font-0xproto-nerd-font
    ;;
  debian | fedora)
    mkdir -p ~/.local/share/fonts
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/0xProto.zip"
    TMP_DIR=$(mktemp -d)
    echo "⬇️ Lade 0xProto Nerd Font herunter..."
    curl -L "$FONT_URL" -o "$TMP_DIR/0xProto.zip"
    unzip -o "$TMP_DIR/0xProto.zip" -d "$TMP_DIR"
    cp "$TMP_DIR"/*.ttf ~/.local/share/fonts/
    fc-cache -fv >/dev/null
    echo "✅ 0xProto Nerd Font installiert (benutzerweit)"
    ;;
  esac
}
# ----------------------------
# Zsh prüfen
# ----------------------------
if ! command -v zsh >/dev/null 2>&1; then
  install_zsh
  if [ $? -ne 0 ]; then
    echo "❌ zshell Installation fehlgeschlagen."
    exit 1
  fi
else
  echo "✅ zshell ist bereits installiert."
fi

# ----------------------------
# Powerlevel10k prüfen
# ----------------------------
if [ ! -d "$HOME/.powerlevel10k" ]; then
  install_powerlevel10k
else
  echo "✅ Powerlevel10k ist bereits installiert."
fi

# ----------------------------
# Schriftart installieren
# ----------------------------
install_fonts

# ----------------------------
# Zsh als Standard setzen
# ----------------------------
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
  echo "⚙️ zshell als Standard-Shell gesetzt. Bitte Terminal neu starten."
fi

echo "✅ Installation erfolgreich."

# ----------------------------
# Benutzerkonfiguration kopieren
# ----------------------------
echo "📁 Starte Setup der Konfigurationsdateien..."

# Alacritty
mkdir -p ~/.config/alacritty/themes
cp ./alacritty.toml ~/.config/alacritty/alacritty.toml
cp ./alacritty.toml ~/.config/alacritty/themes/tokyo-night.toml

# Zsh & Powerlevel10k
cp ./.zshrc ~/.zshrc
cp ./.p10k.zsh ~/.p10k.zsh

echo "✅ Setup abgeschlossen. Starte dein Terminal neu, um Powerlevel10k zu aktivieren."
