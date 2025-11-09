#!/data/data/com.termux/files/usr/bin/bash

echo "=========================================="
echo "  Parando Minecraft Bedrock Server"
echo "=========================================="
echo ""

echo "🛑 Encerrando processos..."

echo "  - Parando servidor Minecraft..."
pkill -f bedrock_server 2>/dev/null

echo "  - Parando painel web..."
pkill -f "node server.js" 2>/dev/null

echo "  - Parando túneis..."
pkill -f cloudflared 2>/dev/null

sleep 2

echo ""
echo "✅ Todos os processos foram encerrados!"
echo ""
