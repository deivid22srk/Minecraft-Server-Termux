#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=========================================="
echo "  Iniciando Minecraft Bedrock Server"
echo "  PocketMine-MP (ARM64 Nativo)"
echo "=========================================="
echo ""

if [ ! -d "pocketmine-server" ] || [ ! -f "pocketmine-server/start.sh" ]; then
    echo "❌ Erro: Servidor não encontrado ou não instalado."
    echo ""
    echo "Execute primeiro:"
    echo "  ./install.sh"
    echo ""
    exit 1
fi

echo "[0/4] Limpando processos anteriores..."
pkill -f "node server.js" 2>/dev/null
pkill -f "bedrock_server" 2>/dev/null
pkill -f "cloudflared" 2>/dev/null
sleep 2
echo "✅ Processos limpos"
echo ""

echo "[1/4] Verificando dependências do painel..."
cd web-panel

if [ ! -d "node_modules" ]; then
    echo "📦 Instalando dependências do Node.js..."
    npm install --silent
    echo "✅ Dependências instaladas"
fi

echo ""
echo "[2/4] Iniciando painel web..."
node server.js > ../web-panel.log 2>&1 &
WEB_PID=$!
echo "✅ Painel web iniciado (PID: $WEB_PID)"

cd ..
sleep 3

echo ""
echo "[3/4] Iniciando túnel público..."
./setup-tunnel.sh > tunnel-setup.log 2>&1 &
TUNNEL_PID=$!
echo "✅ Túnel iniciado (PID: $TUNNEL_PID)"

sleep 5

if [ -f "web-url.txt" ]; then
    echo ""
    echo "=========================================="
    echo "  🌐 URLs PÚBLICAS"
    echo "=========================================="
    echo ""
    WEB_URL=$(cat web-url.txt 2>/dev/null || echo "http://localhost:3000")
    echo "🌐 Painel Web: $WEB_URL"
    echo "🎮 Porta Minecraft: 19132"
    echo ""
fi

echo ""
echo "[4/4] Iniciando servidor Minecraft PocketMine-MP..."
echo "⚠️  Pressione Ctrl+C para parar o servidor"
echo "=========================================="
echo ""
cd pocketmine-server

./start.sh

echo ""
echo "Encerrando processos..."
kill $WEB_PID 2>/dev/null
kill $TUNNEL_PID 2>/dev/null
