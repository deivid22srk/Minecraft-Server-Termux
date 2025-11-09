#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=========================================="
echo "  Iniciando Minecraft Bedrock Server"
echo "=========================================="
echo ""

if [ ! -d "bedrock-server" ]; then
    echo "Erro: Servidor não encontrado. Execute ./install.sh primeiro."
    exit 1
fi

echo "[1/3] Iniciando painel web..."
cd web-panel
node server.js &
WEB_PID=$!
echo "Painel web iniciado (PID: $WEB_PID)"

cd ..
sleep 2

echo ""
echo "[2/3] Iniciando túnel público..."
./setup-tunnel.sh &
TUNNEL_PID=$!

sleep 3

echo ""
echo "[3/3] Iniciando servidor Minecraft..."
cd bedrock-server

export LD_LIBRARY_PATH=.
./bedrock_server

echo ""
echo "Encerrando processos..."
kill $WEB_PID 2>/dev/null
kill $TUNNEL_PID 2>/dev/null
