#!/data/data/com.termux/files/usr/bin/bash

echo "=========================================="
echo "  Teste de Download do Servidor Bedrock"
echo "=========================================="
echo ""

echo "🧪 Testando conectividade e download..."
echo ""

echo "[1/3] Testando conexão básica..."
if ping -c 2 8.8.8.8 &> /dev/null; then
    echo "✅ Internet: OK"
else
    echo "❌ Internet: FALHA"
    exit 1
fi

echo ""
echo "[2/3] Testando DNS..."
if ping -c 2 minecraft.net &> /dev/null; then
    echo "✅ DNS: OK (minecraft.net resolvido)"
else
    echo "❌ DNS: FALHA (não consegue resolver minecraft.net)"
    echo ""
    echo "Execute: ./fix-dns.sh"
    exit 1
fi

echo ""
echo "[3/3] Testando acesso ao servidor de download..."
TEST_URL="https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.121.1.zip"

echo "URL: $TEST_URL"
echo ""

if wget --spider --timeout=10 "$TEST_URL" 2>&1 | grep -q "200 OK"; then
    echo "✅ Servidor de download: ACESSÍVEL"
    echo ""
    echo "=========================================="
    echo "  ✅ TUDO OK!"
    echo "=========================================="
    echo ""
    echo "Você pode executar com segurança:"
    echo "  ./install.sh"
    echo ""
    echo "Ou:"
    echo "  ./download-server.sh"
    echo ""
else
    echo "⚠️  Servidor de download: Problema ao acessar"
    echo ""
    echo "Isso pode significar:"
    echo "  1. Rede instável"
    echo "  2. Firewall bloqueando"
    echo "  3. VPN interferindo"
    echo ""
    echo "Tente:"
    echo "  - Desativar VPN"
    echo "  - Trocar de rede WiFi"
    echo "  - Usar dados móveis"
    echo ""
fi
