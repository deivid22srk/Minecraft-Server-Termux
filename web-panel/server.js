const express = require('express');
const { exec, spawn } = require('child_process');
const fs = require('fs');
const path = require('path');
const multer = require('multer');
const archiver = require('archiver');
const cors = require('cors');
const http = require('http');
const socketIo = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socketIo(server, {
    cors: {
        origin: "*",
        methods: ["GET", "POST"]
    }
});

const PORT = 3000;
const SERVER_DIR = path.join(__dirname, '..', 'pocketmine-server');
const WORLDS_DIR = path.join(SERVER_DIR, 'worlds');
const PLUGINS_DIR = path.join(SERVER_DIR, 'plugins');

app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

const upload = multer({ dest: 'uploads/' });

let serverProcess = null;
let serverStatus = 'stopped';
let serverLogs = [];

function readServerProperties() {
    const propsPath = path.join(SERVER_DIR, 'server.properties');
    if (!fs.existsSync(propsPath)) return {};
    
    const content = fs.readFileSync(propsPath, 'utf8');
    const props = {};
    
    content.split('\n').forEach(line => {
        line = line.trim();
        if (line && !line.startsWith('#')) {
            const [key, value] = line.split('=').map(s => s.trim());
            if (key && value !== undefined) {
                props[key] = value;
            }
        }
    });
    
    return props;
}

function writeServerProperties(props) {
    const propsPath = path.join(SERVER_DIR, 'server.properties');
    let content = '';
    
    for (const [key, value] of Object.entries(props)) {
        content += `${key}=${value}\n`;
    }
    
    fs.writeFileSync(propsPath, content, 'utf8');
}

function readWorldOptions() {
    const worldsPath = WORLDS_DIR;
    
    if (!fs.existsSync(worldsPath)) {
        return { worldName: 'world', exists: false };
    }
    
    const worlds = fs.readdirSync(worldsPath).filter(f => {
        return fs.statSync(path.join(worldsPath, f)).isDirectory();
    });
    
    return {
        worldName: worlds.length > 0 ? worlds[0] : 'world',
        exists: worlds.length > 0,
        worlds: worlds
    };
}

app.get('/api/status', (req, res) => {
    const props = readServerProperties();
    const world = readWorldOptions();
    
    res.json({
        status: serverStatus,
        properties: props,
        world: world,
        logs: serverLogs.slice(-100)
    });
});

app.post('/api/start', (req, res) => {
    if (serverProcess) {
        return res.json({ success: false, message: 'Servidor já está rodando' });
    }
    
    serverProcess = spawn('./start.sh', [], {
        cwd: SERVER_DIR,
        shell: true
    });
    
    serverStatus = 'running';
    serverLogs = [];
    
    serverProcess.stdout.on('data', (data) => {
        const log = data.toString();
        serverLogs.push({ time: new Date(), message: log, type: 'info' });
        io.emit('log', { time: new Date(), message: log, type: 'info' });
    });
    
    serverProcess.stderr.on('data', (data) => {
        const log = data.toString();
        serverLogs.push({ time: new Date(), message: log, type: 'error' });
        io.emit('log', { time: new Date(), message: log, type: 'error' });
    });
    
    serverProcess.on('close', (code) => {
        serverStatus = 'stopped';
        serverProcess = null;
        const log = `Servidor encerrado com código ${code}`;
        serverLogs.push({ time: new Date(), message: log, type: 'info' });
        io.emit('log', { time: new Date(), message: log, type: 'info' });
        io.emit('status', { status: 'stopped' });
    });
    
    io.emit('status', { status: 'running' });
    res.json({ success: true, message: 'Servidor iniciado' });
});

app.post('/api/stop', (req, res) => {
    if (!serverProcess) {
        return res.json({ success: false, message: 'Servidor não está rodando' });
    }
    
    serverProcess.stdin.write('stop\n');
    setTimeout(() => {
        if (serverProcess) {
            serverProcess.kill('SIGTERM');
        }
    }, 5000);
    
    res.json({ success: true, message: 'Comando de parada enviado' });
});

app.post('/api/restart', (req, res) => {
    if (serverProcess) {
        serverProcess.stdin.write('stop\n');
        setTimeout(() => {
            if (serverProcess) {
                serverProcess.kill('SIGTERM');
            }
        }, 5000);
        
        setTimeout(() => {
            serverProcess = spawn('./start.sh', [], {
                cwd: SERVER_DIR,
                shell: true
            });
        }, 6000);
    }
    
    res.json({ success: true, message: 'Servidor reiniciando' });
});

app.post('/api/command', (req, res) => {
    const { command } = req.body;
    
    if (!serverProcess) {
        return res.json({ success: false, message: 'Servidor não está rodando' });
    }
    
    serverProcess.stdin.write(command + '\n');
    res.json({ success: true, message: 'Comando enviado' });
});

app.get('/api/config', (req, res) => {
    const props = readServerProperties();
    res.json(props);
});

app.post('/api/config', (req, res) => {
    const newProps = req.body;
    writeServerProperties(newProps);
    res.json({ success: true, message: 'Configurações salvas' });
});

app.post('/api/gamerule', (req, res) => {
    const { rule, value } = req.body;
    
    if (!serverProcess) {
        return res.json({ success: false, message: 'Servidor precisa estar rodando' });
    }
    
    const command = `gamerule ${rule} ${value}`;
    serverProcess.stdin.write(command + '\n');
    
    res.json({ success: true, message: `Gamerule ${rule} definido para ${value}` });
});

app.post('/api/import-aternos', upload.single('world'), async (req, res) => {
    try {
        if (!req.file) {
            return res.json({ success: false, message: 'Nenhum arquivo enviado' });
        }
        
        const uploadPath = req.file.path;
        const worldBackupDir = path.join(BEDROCK_DIR, 'worlds_backup');
        
        if (!fs.existsSync(worldBackupDir)) {
            fs.mkdirSync(worldBackupDir, { recursive: true });
        }
        
        if (fs.existsSync(WORLDS_DIR)) {
            const backupName = `backup_${Date.now()}`;
            fs.renameSync(WORLDS_DIR, path.join(worldBackupDir, backupName));
        }
        
        fs.mkdirSync(WORLDS_DIR, { recursive: true });
        
        exec(`cd ${WORLDS_DIR} && unzip -o ${uploadPath}`, (error) => {
            fs.unlinkSync(uploadPath);
            
            if (error) {
                return res.json({ success: false, message: 'Erro ao extrair mundo: ' + error.message });
            }
            
            res.json({ success: true, message: 'Mundo importado com sucesso' });
        });
        
    } catch (error) {
        res.json({ success: false, message: 'Erro ao importar: ' + error.message });
    }
});

app.get('/api/download-world', (req, res) => {
    const archive = archiver('zip', { zlib: { level: 9 } });
    
    res.attachment('world-backup.zip');
    archive.pipe(res);
    
    if (fs.existsSync(WORLDS_DIR)) {
        archive.directory(WORLDS_DIR, false);
    }
    
    archive.finalize();
});

app.get('/api/logs', (req, res) => {
    res.json(serverLogs.slice(-200));
});

app.get('/api/tunnel-info', (req, res) => {
    const webUrlPath = path.join(__dirname, '..', 'web-url.txt');
    const mcUrlPath = path.join(__dirname, '..', 'mc-url.txt');
    
    let webUrl = 'http://localhost:3000';
    let mcUrl = 'localhost:19132';
    
    if (fs.existsSync(webUrlPath)) {
        webUrl = fs.readFileSync(webUrlPath, 'utf8').trim();
    }
    
    if (fs.existsSync(mcUrlPath)) {
        mcUrl = fs.readFileSync(mcUrlPath, 'utf8').trim();
    }
    
    res.json({ webUrl, mcUrl });
});

io.on('connection', (socket) => {
    console.log('Cliente conectado ao WebSocket');
    socket.emit('status', { status: serverStatus });
    
    socket.on('disconnect', () => {
        console.log('Cliente desconectado');
    });
});

server.listen(PORT, () => {
    console.log(`========================================`);
    console.log(`  Painel Web ativo na porta ${PORT}`);
    console.log(`  Acesse: http://localhost:${PORT}`);
    console.log(`========================================`);
});
