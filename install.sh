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
echo "[3/6] Baixando Minecraft Bedrock Server 1.21+..."
mkdir -p bedrock-server
cd bedrock-server

echo "🌐 Testando conexão com internet..."
if ! ping -c 1 google.com &> /dev/null; then
    echo "❌ Erro: Sem conexão com internet!"
    echo "Verifique sua conexão e tente novamente."
    exit 1
fi
echo "✅ Conexão OK"

echo ""
echo "📦 Baixando servidor Bedrock..."
echo "Isso pode levar alguns minutos dependendo da conexão."
echo ""

BEDROCK_URLS=(
    "https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.121.1.zip"
    "https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.50.07.zip"
    "https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.44.01.zip"
)

DOWNLOAD_SUCCESS=false

for URL in "${BEDROCK_URLS[@]}"; do
    echo "Tentando: $URL"
    
    if wget --timeout=30 --tries=3 -O bedrock-server.zip "$URL" 2>&1 | grep -q "saved"; then
        if [ -f "bedrock-server.zip" ] && [ -s "bedrock-server.zip" ]; then
            FILE_SIZE=$(stat -c%s "bedrock-server.zip" 2>/dev/null || stat -f%z "bedrock-server.zip" 2>/dev/null || echo "0")
            if [ "$FILE_SIZE" -gt 1000000 ]; then
                echo "✅ Download bem-sucedido! (${FILE_SIZE} bytes)"
                DOWNLOAD_SUCCESS=true
                break
            else
                echo "⚠️  Arquivo muito pequeno, tentando próxima URL..."
                rm -f bedrock-server.zip
            fi
        fi
    else
        echo "⚠️  Falha no download, tentando próxima URL..."
        rm -f bedrock-server.zip
    fi
    sleep 2
done

if [ "$DOWNLOAD_SUCCESS" = false ]; then
    echo ""
    echo "❌ ERRO: Não foi possível baixar o servidor Bedrock!"
    echo ""
    echo "Possíveis causas:"
    echo "  1. Problema de DNS no Termux"
    echo "  2. Conexão instável"
    echo "  3. Servidores da Microsoft fora do ar"
    echo ""
    echo "Soluções:"
    echo "  1. Execute: termux-change-repo (escolha um mirror mais próximo)"
    echo "  2. Reinicie o Termux e tente novamente"
    echo "  3. Verifique sua conexão WiFi/dados móveis"
    echo "  4. Execute: ./download-server.sh (download manual)"
    echo ""
    exit 1
fi

echo ""
echo "[4/6] Extraindo arquivos do servidor..."

if ! unzip -t bedrock-server.zip &> /dev/null; then
    echo "❌ Erro: Arquivo ZIP corrompido!"
    echo "Execute ./install.sh novamente ou use ./download-server.sh"
    exit 1
fi

unzip -o bedrock-server.zip
rm bedrock-server.zip

if [ ! -f "bedrock_server" ]; then
    echo "❌ Erro: bedrock_server não foi extraído!"
    echo "O arquivo ZIP pode estar incompleto."
    exit 1
fi

chmod +x bedrock_server
echo "✅ Servidor extraído com sucesso!"

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
