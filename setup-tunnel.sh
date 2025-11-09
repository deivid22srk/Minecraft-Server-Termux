#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=========================================="
echo "  Configurando Túnel Público"
echo "=========================================="
echo ""

if ! command -v cloudflared &> /dev/null; then
    if [ -f "cloudflared" ]; then
        echo "[1/2] Instalando Cloudflare Tunnel local..."
        chmod +x cloudflared
        mv cloudflared $PREFIX/bin/
    else
        echo "[1/2] Baixando Cloudflare Tunnel..."
        
        ARCH=$(uname -m)
        if [ "$ARCH" = "aarch64" ]; then
            wget -q --show-progress https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64 -O cloudflared
        elif [ "$ARCH" = "x86_64" ]; then
            wget -q --show-progress https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared
        else
            wget -q --show-progress https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm -O cloudflared
        fi
        
        chmod +x cloudflared
        mv cloudflared $PREFIX/bin/
    fi
else
    echo "[1/2] Cloudflare Tunnel já instalado ✅"
fi

echo ""
echo "[2/2] Iniciando túneis..."

echo "Túnel para painel web (porta 3000)..."
cloudflared tunnel --url http://localhost:3000 > tunnel-web.log 2>&1 &
WEB_TUNNEL_PID=$!

sleep 3

echo "Túnel para servidor Minecraft (porta 19132)..."
cloudflared tunnel --url udp://localhost:19132 > tunnel-mc.log 2>&1 &
MC_TUNNEL_PID=$!

sleep 3

echo ""
echo "=========================================="
echo "  Túneis Ativos"
echo "=========================================="
echo ""

if [ -f "tunnel-web.log" ]; then
    WEB_URL=$(grep -o 'https://[^[:space:]]*\.trycloudflare\.com' tunnel-web.log | head -1)
    if [ ! -z "$WEB_URL" ]; then
        echo "🌐 Painel Web: $WEB_URL"
        echo "$WEB_URL" > web-url.txt
    fi
fi

if [ -f "tunnel-mc.log" ]; then
    MC_URL=$(grep -o 'https://[^[:space:]]*\.trycloudflare\.com' tunnel-mc.log | head -1)
    if [ ! -z "$MC_URL" ]; then
        echo "🎮 Servidor Minecraft: $MC_URL"
        echo "$MC_URL" > mc-url.txt
    fi
fi

echo ""
echo "URLs salvas em web-url.txt e mc-url.txt"
echo "=========================================="

wait
