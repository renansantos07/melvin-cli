#!/bin/bash

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="melvin"
VERSION="1.0.0"
SOURCE_DIR="$(dirname "$(realpath "$0")")/bin"

echo "🔄 Instalando $SCRIPT_NAME versão $VERSION..."

# Criar diretório de instalação se não existir
if [ ! -d "$INSTALL_DIR" ]; then
  echo "📂 Criando diretório $INSTALL_DIR..."
  sudo mkdir -p "$INSTALL_DIR"
fi

# Verifica se o arquivo fonte existe antes de copiar
if [ -f "$SOURCE_DIR/melvin.sh" ]; then
  echo "📥 Copiando $SCRIPT_NAME para $INSTALL_DIR..."
  sudo cp "$SOURCE_DIR/melvin.sh" "$INSTALL_DIR/melvin"
  sudo chmod +x "$INSTALL_DIR/melvin"
else
  echo "❌ Erro: Arquivo melvin.sh não encontrado em '$SOURCE_DIR'!"
  exit 1
fi

# Adicionar alias ao ~/.bashrc ou ~/.zshrc, se ainda não estiver lá
if [ -f "$HOME/.bashrc" ]; then
  if ! grep -q "alias melvin=" "$HOME/.bashrc"; then
    echo "🔧 Adicionando alias ao ~/.bashrc..."
    echo "alias melvin='$INSTALL_DIR/melvin'" >> "$HOME/.bashrc"
  fi
fi

if [ -f "$HOME/.zshrc" ]; then
  if ! grep -q "alias melvin=" "$HOME/.zshrc"; then
    echo "🔧 Adicionando alias ao ~/.zshrc..."
    echo "alias melvin='$INSTALL_DIR/melvin'" >> "$HOME/.zshrc"
  fi
fi

echo "✅ Instalação concluída! Reinicie o terminal ou execute 'source ~/.bashrc' (ou 'source ~/.zshrc') para usar."
