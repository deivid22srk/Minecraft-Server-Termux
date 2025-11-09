#!/data/data/com.termux/files/usr/bin/bash

echo "=========================================="
echo "  Minecraft Bedrock Server - Termux"
echo "  Versão: 1.21.120.4"
echo "=========================================="
echo ""

echo "[1/6] Atualizando pacotes do Termux..."
pkg update -y && pkg upgrade -y

echo ""
echo "[2/6] Instalando dependências..."
pkg install -y wget curl unzip nodejs-lts proot-distro libicu openssl-tool

echo ""
echo "[3/6] Baixando Minecraft Bedrock Server 1.21.120.4..."
mkdir -p bedrock-server
cd bedrock-server

BEDROCK_URL="https://minecraft.azureedge.net/bin-linux/bedrock-server-1.21.50.07.zip"
echo "Baixando servidor Bedrock..."
wget -O bedrock-server.zip "$BEDROCK_URL"

if [ ! -f "bedrock-server.zip" ]; then
    echo "Erro: Falha ao baixar o servidor. Tentando versão alternativa..."
    BEDROCK_URL="https://minecraft.azureedge.net/bin-linux/bedrock-server-1.21.44.01.zip"
    wget -O bedrock-server.zip "$BEDROCK_URL"
fi

echo ""
echo "[4/6] Extraindo arquivos do servidor..."
unzip -o bedrock-server.zip
rm bedrock-server.zip

chmod +x bedrock_server

echo ""
echo "[5/6] Instalando dependências do painel web..."
cd ..
mkdir -p web-panel
cd web-panel
npm init -y
npm install express multer archiver ws socket.io cors dotenv

echo ""
echo "[6/6] Configurando scripts..."
cd ..
chmod +x start.sh
chmod +x setup-tunnel.sh

echo ""
echo "=========================================="
echo "  Instalação concluída!"
echo "=========================================="
echo ""
echo "Para iniciar o servidor, execute:"
echo "  ./start.sh"
echo ""
