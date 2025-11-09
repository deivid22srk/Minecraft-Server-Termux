#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

show_menu() {
    echo "=========================================="
    echo "  Minecraft Bedrock Server - Menu"
    echo "  PocketMine-MP (ARM64)"
    echo "=========================================="
    echo ""
    echo "1. Iniciar servidor"
    echo "2. Parar servidor"
    echo "3. Ver logs"
    echo "4. Reiniciar túnel"
    echo "5. Ver URLs públicas"
    echo "6. Backup do mundo"
    echo "7. Restaurar backup"
    echo "8. Limpar logs"
    echo "9. Atualizar PocketMine-MP"
    echo "0. Sair"
    echo ""
    echo -n "Escolha uma opção: "
}

start_server() {
    echo "Iniciando servidor..."
    ./start.sh
}

stop_server() {
    echo "Parando servidor..."
    pkill -f PocketMine-MP
    pkill -f "php.*phar"
    pkill -f "node server.js"
    pkill -f cloudflared
    echo "Servidor parado."
}

view_logs() {
    if [ -f "pocketmine-server/server.log" ]; then
        tail -f pocketmine-server/server.log
    else
        echo "Nenhum log encontrado."
    fi
}

restart_tunnel() {
    echo "Reiniciando túneis..."
    pkill -f cloudflared
    ./setup-tunnel.sh &
    echo "Túneis reiniciados."
}

show_urls() {
    echo "=========================================="
    echo "  URLs Públicas"
    echo "=========================================="
    echo ""
    
    if [ -f "web-url.txt" ]; then
        echo "🌐 Painel Web: $(cat web-url.txt)"
    else
        echo "🌐 Painel Web: http://localhost:3000"
    fi
    
    if [ -f "mc-url.txt" ]; then
        echo "🎮 Servidor Minecraft: $(cat mc-url.txt)"
    else
        echo "🎮 Servidor Minecraft: localhost:19132"
    fi
    
    echo ""
}

backup_world() {
    echo "Criando backup do mundo..."
    BACKUP_DIR="backups/$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    if [ -d "pocketmine-server/worlds" ]; then
        cp -r pocketmine-server/worlds "$BACKUP_DIR/"
        cp -r pocketmine-server/players "$BACKUP_DIR/" 2>/dev/null
        echo "✅ Backup criado em: $BACKUP_DIR"
    else
        echo "❌ Nenhum mundo encontrado para backup."
    fi
}

restore_backup() {
    echo "Backups disponíveis:"
    echo ""
    ls -1 backups/ 2>/dev/null
    echo ""
    echo -n "Digite o nome do backup para restaurar: "
    read BACKUP_NAME
    
    if [ -d "backups/$BACKUP_NAME" ]; then
        echo "Restaurando backup..."
        rm -rf pocketmine-server/worlds
        rm -rf pocketmine-server/players
        cp -r "backups/$BACKUP_NAME/worlds" pocketmine-server/
        cp -r "backups/$BACKUP_NAME/players" pocketmine-server/ 2>/dev/null
        echo "✅ Backup restaurado com sucesso!"
    else
        echo "❌ Backup não encontrado."
    fi
}

clean_logs() {
    echo "Limpando logs..."
    rm -f *.log
    rm -f pocketmine-server/*.log
    echo "✅ Logs limpos."
}

update_server() {
    echo "Atualizando PocketMine-MP..."
    echo "⚠️  Esta operação irá atualizar o servidor para a versão mais recente."
    echo -n "Continuar? (s/n): "
    read CONFIRM
    
    if [ "$CONFIRM" = "s" ] || [ "$CONFIRM" = "S" ]; then
        echo "Parando servidor..."
        stop_server
        sleep 2
        
        echo "Atualizando..."
        cd pocketmine-server
        curl -sL https://get.pmmp.io | bash -s -
        cd ..
        
        echo "✅ Atualização concluída!"
    else
        echo "Atualização cancelada."
    fi
}

while true; do
    show_menu
    read OPTION
    echo ""
    
    case $OPTION in
        1) start_server ;;
        2) stop_server ;;
        3) view_logs ;;
        4) restart_tunnel ;;
        5) show_urls ;;
        6) backup_world ;;
        7) restore_backup ;;
        8) clean_logs ;;
        9) update_server ;;
        0) echo "Até logo!"; exit 0 ;;
        *) echo "Opção inválida!" ;;
    esac
    echo ""
    echo -n "Pressione ENTER para continuar..."
    read
    clear
done
