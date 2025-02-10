#!/bin/bash

REPO="renansantos07/melvin-cli"
INSTALL_DIR="/usr/local/bin"
VERSION=$(curl -s https://raw.githubusercontent.com/$REPO/main/VERSION)
CURRENT_VERSION=$(cat $INSTALL_DIR/VERSION 2>/dev/null || echo "0.0.0")

if [ "$VERSION" != "$CURRENT_VERSION" ]; then
  echo "Atualizando para versão $VERSION..."
  curl -L "https://raw.githubusercontent.com/$REPO/main/bin/melvin.sh" -o "$INSTALL_DIR/melvin"
  chmod +x "$INSTALL_DIR/melvin"
  echo "$VERSION" > "$INSTALL_DIR/VERSION"
  echo "Atualização concluída!"
else
  echo "Você já está na versão mais recente ($CURRENT_VERSION)."
fi
