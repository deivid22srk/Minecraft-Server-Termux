#!/data/data/com.termux/files/usr/bin/bash

echo "=========================================="
echo "  Download Manual do Servidor Bedrock"
echo "=========================================="
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "🌐 Verificando conexão..."
if ! ping -c 1 8.8.8.8 &> /dev/null; then
    echo "❌ Erro: Sem conexão com internet!"
    echo "Verifique sua conexão WiFi ou dados móveis."
    exit 1
fi
echo "✅ Conexão OK"

echo ""
echo "📦 Preparando diretório..."
mkdir -p bedrock-server
cd bedrock-server

if [ -f "bedrock_server" ]; then
    echo "⚠️  Servidor já existe!"
    echo -n "Deseja substituir? (s/n): "
    read CONFIRM
    if [ "$CONFIRM" != "s" ] && [ "$CONFIRM" != "S" ]; then
        echo "Download cancelado."
        exit 0
    fi
    echo "Removendo servidor antigo..."
    rm -rf *
fi

echo ""
echo "🔍 URLs de Download Disponíveis:"
echo ""
echo "1. Versão 1.21.121.1 (Mais recente - Nov 2025)"
echo "2. Versão 1.21.50.07 (Estável)"
echo "3. Versão 1.21.44.01 (Compatível)"
echo "4. Tentar todas automaticamente"
echo ""
echo -n "Escolha uma opção (1-4) [4]: "
read CHOICE

CHOICE=${CHOICE:-4}

case $CHOICE in
    1)
        URLS=("https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.121.1.zip")
        ;;
    2)
        URLS=("https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.50.07.zip")
        ;;
    3)
        URLS=("https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.44.01.zip")
        ;;
    4)
        URLS=(
            "https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.121.1.zip"
            "https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.50.07.zip"
            "https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.44.01.zip"
        )
        ;;
    *)
        echo "Opção inválida!"
        exit 1
        ;;
esac

echo ""
echo "📥 Iniciando download..."
echo ""

DOWNLOAD_SUCCESS=false

for URL in "${URLS[@]}"; do
    echo "=========================================="
    echo "Tentando baixar:"
    echo "$URL"
    echo "=========================================="
    echo ""
    
    wget --progress=bar:force --timeout=60 --tries=5 -O bedrock-server.zip "$URL"
    WGET_EXIT=$?
    
    if [ $WGET_EXIT -eq 0 ] && [ -f "bedrock-server.zip" ]; then
        FILE_SIZE=$(stat -c%s "bedrock-server.zip" 2>/dev/null || stat -f%z "bedrock-server.zip" 2>/dev/null || echo "0")
        
        if [ "$FILE_SIZE" -gt 1000000 ]; then
            echo ""
            echo "✅ Download concluído! ($(echo "scale=2; $FILE_SIZE/1024/1024" | bc) MB)"
            
            echo ""
            echo "🔍 Verificando integridade..."
            if unzip -t bedrock-server.zip &> /dev/null; then
                echo "✅ Arquivo ZIP válido!"
                DOWNLOAD_SUCCESS=true
                break
            else
                echo "❌ Arquivo corrompido, tentando novamente..."
                rm -f bedrock-server.zip
            fi
        else
            echo "⚠️  Arquivo muito pequeno ($FILE_SIZE bytes), tentando próxima URL..."
            rm -f bedrock-server.zip
        fi
    else
        echo ""
        echo "❌ Falha no download (código: $WGET_EXIT)"
        echo "Tentando próxima URL..."
        rm -f bedrock-server.zip
    fi
    
    echo ""
    sleep 2
done

if [ "$DOWNLOAD_SUCCESS" = false ]; then
    echo ""
    echo "=========================================="
    echo "  ❌ DOWNLOAD FALHOU"
    echo "=========================================="
    echo ""
    echo "Possíveis soluções:"
    echo ""
    echo "1️⃣  Trocar repositório do Termux:"
    echo "    termux-change-repo"
    echo "    (Escolha um mirror mais próximo)"
    echo ""
    echo "2️⃣  Configurar DNS:"
    echo "    echo 'nameserver 8.8.8.8' > \$PREFIX/etc/resolv.conf"
    echo ""
    echo "3️⃣  Reiniciar Termux e tentar novamente"
    echo ""
    echo "4️⃣  Baixar manualmente no PC e transferir:"
    echo "    https://www.minecraft.net/en-us/download/server/bedrock"
    echo "    Depois copie para: ~/Minecraft-Server-Termux/bedrock-server/"
    echo ""
    exit 1
fi

echo ""
echo "📦 Extraindo arquivos..."
unzip -o bedrock-server.zip

if [ ! -f "bedrock_server" ]; then
    echo "❌ Erro ao extrair bedrock_server!"
    exit 1
fi

rm bedrock-server.zip
chmod +x bedrock_server

echo ""
echo "✅ Configurando permissões..."
chmod +x bedrock_server

echo ""
echo "=========================================="
echo "  ✅ SERVIDOR INSTALADO COM SUCESSO!"
echo "=========================================="
echo ""
echo "Para iniciar o servidor:"
echo "  cd .."
echo "  ./start.sh"
echo ""
