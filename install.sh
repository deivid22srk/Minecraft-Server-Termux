#!/data/data/com.termux/files/usr/bin/bash

echo "=========================================="
echo "  Minecraft Bedrock Server - Termux"
echo "  PocketMine-MP (ARM64 Nativo)"
echo "  Versão: 5.37.0+ (Bedrock 1.21.120)"
echo "=========================================="
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "[1/6] Atualizando pacotes do Termux..."
pkg update -y && pkg upgrade -y

echo ""
echo "[2/6] Instalando dependências básicas..."
pkg install -y wget curl unzip nodejs-lts

echo ""
echo "[3/6] Instalando ferramentas de compilação para PHP..."
echo "Isso é necessário para o PocketMine-MP compilar extensões PHP..."
pkg install -y \
    php \
    make \
    clang \
    autoconf \
    automake \
    libtool \
    m4 \
    bison \
    re2c \
    pkg-config \
    cmake \
    binutils \
    git

echo ""
echo "[4/6] Baixando e instalando PocketMine-MP..."
mkdir -p pocketmine-server
cd pocketmine-server

echo "🌐 Verificando conexão..."
if ! ping -c 1 google.com &> /dev/null; then
    echo "❌ Erro: Sem conexão com internet!"
    exit 1
fi
echo "✅ Conexão OK"

echo ""
echo "📦 Instalando PocketMine-MP (servidor nativo ARM64)..."
echo "⏱️  Isso pode levar 10-20 minutos para compilar o PHP..."
echo "☕ Tome um café enquanto isso... não interrompa o processo!"
echo ""

if command -v curl &> /dev/null; then
    curl -sL https://get.pmmp.io | bash -s -
else
    wget -q -O - https://get.pmmp.io | bash -s -
fi

if [ ! -f "start.sh" ]; then
    echo ""
    echo "❌ Erro na instalação do PocketMine-MP"
    echo ""
    echo "Verifique os erros acima."
    echo "Possíveis causas:"
    echo "  1. Compilação do PHP falhou (falta de memória)"
    echo "  2. Falta alguma dependência"
    echo "  3. Espaço em disco insuficiente"
    echo ""
    echo "Tente:"
    echo "  - Fechar outros apps no Android"
    echo "  - Liberar espaço (mínimo 500MB)"
    echo "  - Executar ./install.sh novamente"
    exit 1
fi

chmod +x start.sh
chmod +x PocketMine-MP.phar 2>/dev/null

if [ -f "bin/php7/bin/php" ]; then
    chmod +x bin/php7/bin/php
fi

echo ""
echo "✅ PocketMine-MP instalado com sucesso!"

cd ..

echo ""
echo "[5/6] Instalando dependências do painel web..."
cd web-panel

if [ ! -d "node_modules" ]; then
    npm install --silent
fi

cd ..

echo ""
echo "[6/6] Configurando scripts..."
chmod +x *.sh 2>/dev/null

echo ""
echo "=========================================="
echo "  Instalação concluída!"
echo "=========================================="
echo ""
echo "✅ Servidor PocketMine-MP instalado (nativo ARM64)"
echo "✅ Suporta Minecraft Bedrock 1.21.120+"
echo "✅ Painel web configurado"
echo ""
echo "Para iniciar o servidor, execute:"
echo "  ./start.sh"
echo ""
