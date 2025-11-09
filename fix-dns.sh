#!/data/data/com.termux/files/usr/bin/bash

echo "=========================================="
echo "  Correção de Problemas de DNS/Rede"
echo "=========================================="
echo ""

echo "Este script tenta corrigir problemas de DNS no Termux."
echo ""

echo "[1/4] Testando conexão atual..."
if ping -c 1 google.com &> /dev/null; then
    echo "✅ Conexão com Google OK"
else
    echo "❌ Falha ao conectar com Google"
fi

if ping -c 1 8.8.8.8 &> /dev/null; then
    echo "✅ Conexão com IP 8.8.8.8 OK"
else
    echo "❌ Falha ao conectar com IP"
fi

echo ""
echo "[2/4] Configurando DNS do Google (8.8.8.8)..."
echo "nameserver 8.8.8.8" > $PREFIX/etc/resolv.conf
echo "nameserver 8.8.4.4" >> $PREFIX/etc/resolv.conf
echo "✅ DNS configurado"

echo ""
echo "[3/4] Testando resolução de nomes..."
if nslookup minecraft.net &> /dev/null; then
    echo "✅ DNS funcionando! (minecraft.net resolvido)"
else
    echo "⚠️  DNS ainda com problemas"
    echo ""
    echo "Tente:"
    echo "  1. Mudar de rede WiFi"
    echo "  2. Usar dados móveis em vez de WiFi"
    echo "  3. Reiniciar o Termux"
fi

echo ""
echo "[4/4] Limpando cache..."
rm -rf $PREFIX/var/cache/apt/archives/*.deb 2>/dev/null
echo "✅ Cache limpo"

echo ""
echo "=========================================="
echo "  Configuração Concluída"
echo "=========================================="
echo ""
echo "Tente executar novamente:"
echo "  ./install.sh"
echo ""
echo "Ou:"
echo "  ./download-server.sh"
echo ""
