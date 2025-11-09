const socket = io();

let serverStatus = 'stopped';
let config = {};

const statusIndicator = document.getElementById('status-indicator');
const btnStart = document.getElementById('btn-start');
const btnStop = document.getElementById('btn-stop');
const btnRestart = document.getElementById('btn-restart');
const btnSendCommand = document.getElementById('btn-send-command');
const commandInput = document.getElementById('command-input');
const consoleOutput = document.getElementById('console-output');
const serverIp = document.getElementById('server-ip');
const serverPort = document.getElementById('server-port');

const showCoordinates = document.getElementById('show-coordinates');
const keepInventory = document.getElementById('keep-inventory');
const pvp = document.getElementById('pvp');
const friendlyFire = document.getElementById('friendly-fire');
const btnApplyGamerules = document.getElementById('btn-apply-gamerules');

const btnSaveConfig = document.getElementById('btn-save-config');
const btnImport = document.getElementById('btn-import');
const btnDownload = document.getElementById('btn-download');
const worldFile = document.getElementById('world-file');

function showNotification(message, type = 'success') {
    const notification = document.getElementById('notification');
    notification.textContent = message;
    notification.className = `notification ${type} show`;
    
    setTimeout(() => {
        notification.classList.remove('show');
    }, 3000);
}

function addLogEntry(message, type = 'info') {
    const entry = document.createElement('div');
    entry.className = `log-entry ${type}`;
    const time = new Date().toLocaleTimeString();
    entry.textContent = `[${time}] ${message}`;
    consoleOutput.appendChild(entry);
    consoleOutput.scrollTop = consoleOutput.scrollHeight;
}

function updateStatus(status) {
    serverStatus = status;
    
    if (status === 'running') {
        statusIndicator.textContent = 'Rodando';
        statusIndicator.className = 'status running';
        btnStart.disabled = true;
        btnStop.disabled = false;
        btnRestart.disabled = false;
    } else {
        statusIndicator.textContent = 'Parado';
        statusIndicator.className = 'status stopped';
        btnStart.disabled = false;
        btnStop.disabled = true;
        btnRestart.disabled = true;
    }
}

function updateUI(data) {
    if (data.status) {
        updateStatus(data.status);
    }
    
    if (data.properties) {
        config = data.properties;
        
        document.getElementById('cfg-server-name').value = config['server-name'] || '';
        document.getElementById('cfg-gamemode').value = config['gamemode'] || 'survival';
        document.getElementById('cfg-difficulty').value = config['difficulty'] || 'normal';
        document.getElementById('cfg-max-players').value = config['max-players'] || 10;
        document.getElementById('cfg-view-distance').value = config['view-distance'] || 32;
        document.getElementById('cfg-port').value = config['server-port'] || 19132;
        
        serverPort.value = config['server-port'] || 19132;
    }
    
    if (data.logs) {
        consoleOutput.innerHTML = '';
        data.logs.slice(-50).forEach(log => {
            addLogEntry(log.message, log.type);
        });
    }
}

function loadStatus() {
    fetch('/api/status')
        .then(res => res.json())
        .then(data => {
            updateUI(data);
        })
        .catch(err => {
            console.error('Erro ao carregar status:', err);
        });
}

function loadTunnelInfo() {
    fetch('/api/tunnel-info')
        .then(res => res.json())
        .then(data => {
            if (data.mcUrl) {
                serverIp.value = data.mcUrl;
            }
        })
        .catch(err => {
            console.error('Erro ao carregar informações do túnel:', err);
        });
}

btnStart.addEventListener('click', () => {
    fetch('/api/start', { method: 'POST' })
        .then(res => res.json())
        .then(data => {
            if (data.success) {
                showNotification('Servidor iniciado com sucesso!', 'success');
                updateStatus('running');
            } else {
                showNotification(data.message, 'error');
            }
        })
        .catch(err => {
            showNotification('Erro ao iniciar servidor', 'error');
        });
});

btnStop.addEventListener('click', () => {
    fetch('/api/stop', { method: 'POST' })
        .then(res => res.json())
        .then(data => {
            showNotification(data.message, data.success ? 'success' : 'error');
        });
});

btnRestart.addEventListener('click', () => {
    fetch('/api/restart', { method: 'POST' })
        .then(res => res.json())
        .then(data => {
            showNotification(data.message, data.success ? 'success' : 'error');
        });
});

btnSendCommand.addEventListener('click', () => {
    const command = commandInput.value.trim();
    if (!command) return;
    
    fetch('/api/command', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ command })
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            addLogEntry(`> ${command}`, 'success');
            commandInput.value = '';
        } else {
            showNotification(data.message, 'error');
        }
    });
});

commandInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
        btnSendCommand.click();
    }
});

btnApplyGamerules.addEventListener('click', () => {
    const gamerules = [
        { rule: 'showcoordinates', value: showCoordinates.checked },
        { rule: 'keepinventory', value: keepInventory.checked },
        { rule: 'pvp', value: pvp.checked },
        { rule: 'friendlyfire', value: friendlyFire.checked }
    ];
    
    if (serverStatus !== 'running') {
        showNotification('O servidor precisa estar rodando para aplicar game rules', 'error');
        return;
    }
    
    let count = 0;
    gamerules.forEach(({ rule, value }) => {
        fetch('/api/gamerule', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ rule, value })
        })
        .then(res => res.json())
        .then(data => {
            count++;
            if (count === gamerules.length) {
                showNotification('Game rules aplicadas com sucesso!', 'success');
            }
        });
    });
});

btnSaveConfig.addEventListener('click', () => {
    const newConfig = {
        'server-name': document.getElementById('cfg-server-name').value,
        'gamemode': document.getElementById('cfg-gamemode').value,
        'difficulty': document.getElementById('cfg-difficulty').value,
        'max-players': document.getElementById('cfg-max-players').value,
        'view-distance': document.getElementById('cfg-view-distance').value,
        'server-port': document.getElementById('cfg-port').value,
        'server-portv6': document.getElementById('cfg-port').value,
        ...config
    };
    
    fetch('/api/config', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(newConfig)
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            showNotification('Configurações salvas! Reinicie o servidor para aplicar.', 'success');
        } else {
            showNotification('Erro ao salvar configurações', 'error');
        }
    });
});

btnImport.addEventListener('click', () => {
    const file = worldFile.files[0];
    if (!file) {
        showNotification('Selecione um arquivo primeiro', 'error');
        return;
    }
    
    const formData = new FormData();
    formData.append('world', file);
    
    showNotification('Importando mundo... Isso pode levar alguns minutos.', 'success');
    
    fetch('/api/import-aternos', {
        method: 'POST',
        body: formData
    })
    .then(res => res.json())
    .then(data => {
        showNotification(data.message, data.success ? 'success' : 'error');
        if (data.success) {
            worldFile.value = '';
        }
    })
    .catch(err => {
        showNotification('Erro ao importar mundo', 'error');
    });
});

btnDownload.addEventListener('click', () => {
    showNotification('Iniciando download do mundo...', 'success');
    window.location.href = '/api/download-world';
});

function copyToClipboard(elementId) {
    const element = document.getElementById(elementId);
    element.select();
    element.setSelectionRange(0, 99999);
    
    navigator.clipboard.writeText(element.value).then(() => {
        showNotification('Copiado para área de transferência!', 'success');
    }).catch(() => {
        document.execCommand('copy');
        showNotification('Copiado para área de transferência!', 'success');
    });
}

socket.on('status', (data) => {
    updateStatus(data.status);
});

socket.on('log', (log) => {
    addLogEntry(log.message, log.type);
});

socket.on('connect', () => {
    addLogEntry('Conectado ao servidor', 'success');
    loadStatus();
});

socket.on('disconnect', () => {
    addLogEntry('Desconectado do servidor', 'error');
});

loadStatus();
loadTunnelInfo();

setInterval(loadTunnelInfo, 30000);
