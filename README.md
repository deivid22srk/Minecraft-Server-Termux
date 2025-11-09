# 🎮 Minecraft Bedrock Server para Termux

Servidor completo de Minecraft Bedrock Edition versão 1.21+ com painel web de gerenciamento, acesso público via túnel e importação de mundos do Aternos.

## ✨ Características

- ✅ Servidor Minecraft Bedrock Edition otimizado para Termux
- 🌐 Painel web completo para gerenciamento
- 🔓 Acesso público via Cloudflare Tunnel (não é localhost!)
- 📥 Importação de mundos do Aternos
- ⚙️ Configurações em tempo real (coordenadas, keepInventory, etc.)
- 💬 Console ao vivo com logs em tempo real
- 📊 Controle total do servidor (iniciar, parar, reiniciar)
- 🎯 Game rules configuráveis pela interface
- 💾 Backup e download de mundos

## 📋 Requisitos

- Android com Termux instalado
- Pelo menos 2GB de RAM disponível
- Espaço de armazenamento: ~500MB
- Conexão com internet

## 🚀 Instalação

### 1. Clone o repositório

```bash
pkg install git
git clone https://github.com/deivid22srk/Minecraft-Server-Termux.git
cd Minecraft-Server-Termux
```

### 2. Dê permissões aos scripts

```bash
chmod +x install.sh start.sh setup-tunnel.sh
```

### 3. Execute a instalação

```bash
./install.sh
```

A instalação irá:
- Atualizar os pacotes do Termux
- Instalar todas as dependências necessárias
- Baixar o servidor Bedrock
- Configurar o painel web
- Instalar o Cloudflare Tunnel

⏱️ **Tempo estimado:** 10-15 minutos (dependendo da conexão)

## 🎯 Como Usar

### Iniciar o Servidor

```bash
./start.sh
```

Este comando irá:
1. Iniciar o painel web na porta 3000
2. Configurar os túneis públicos
3. Iniciar o servidor Minecraft

### Acessar o Painel Web

Após iniciar, você verá as URLs públicas no console:

```
🌐 Painel Web: https://xxx.trycloudflare.com
🎮 Servidor Minecraft: https://yyy.trycloudflare.com
```

**Acesse o painel web pelo navegador usando a URL exibida!**

## 🎮 Conectar ao Servidor

1. Abra Minecraft Bedrock no seu dispositivo
2. Vá em "Jogar" → "Servidores" → "Adicionar Servidor"
3. Use o endereço mostrado no painel web
4. Porta: 19132

**Importante:** Qualquer pessoa com o endereço pode se conectar de qualquer rede WiFi!

## 📥 Importar Mundo do Aternos

### Passo 1: Baixar o mundo do Aternos

1. Acesse seu servidor no [Aternos](https://aternos.org)
2. Vá em **"Worlds"** (Mundos)
3. Selecione o mundo que deseja exportar
4. Clique em **"Download"** (Baixar)
5. Salve o arquivo `.zip` ou `.mcworld`

### Passo 2: Importar no painel web

1. Acesse o painel web
2. Vá na seção **"📥 Importar do Aternos"**
3. Clique em **"Escolher arquivo"** e selecione o arquivo baixado
4. Clique em **"📤 Importar Mundo"**
5. Aguarde a conclusão (pode levar alguns minutos)
6. Reinicie o servidor

## ⚙️ Configurações Rápidas

O painel web permite configurar facilmente:

### Game Rules (Com servidor rodando)

- ✅ **Mostrar Coordenadas:** Exibe X, Y, Z na tela
- ✅ **Manter Inventário:** Não perde itens ao morrer
- ✅ **PvP:** Permite combate entre jogadores
- ✅ **Fogo Amigo:** Dano entre membros do time

**Aplique clicando no botão "Aplicar Game Rules"**

### Configurações do Servidor (Requer reinício)

- Nome do servidor
- Modo de jogo (Sobrevivência, Criativo, Aventura)
- Dificuldade (Pacífico, Fácil, Normal, Difícil)
- Máximo de jogadores
- Distância de renderização
- Porta do servidor

## 💬 Console e Comandos

O painel possui um console integrado onde você pode:

- Ver logs em tempo real
- Executar comandos do servidor
- Monitorar jogadores conectados

### Comandos Úteis

```
say Olá jogadores!           # Enviar mensagem
kick jogador                 # Expulsar jogador
op jogador                   # Dar permissões de admin
deop jogador                 # Remover permissões
difficulty peaceful          # Mudar dificuldade
gamemode creative jogador    # Mudar modo de jogo
time set day                 # Mudar hora do dia
weather clear                # Limpar tempo
```

## 🔧 Solução de Problemas

### O servidor não inicia

```bash
cd bedrock-server
export LD_LIBRARY_PATH=.
./bedrock_server
```

Verifique os erros no console.

### Porta já em uso

Edite `bedrock-server/server.properties` e mude a porta:

```
server-port=19133
server-portv6=19133
```

### Túnel não conecta

Reinstale o cloudflared:

```bash
rm $PREFIX/bin/cloudflared
./setup-tunnel.sh
```

### Mundo não importa

Certifique-se de que:
- O arquivo está em formato `.zip` ou `.mcworld`
- O servidor está parado durante a importação
- Há espaço suficiente em disco

### Painel web não abre

Verifique se o Node.js está instalado:

```bash
node --version
npm --version
```

Reinstale as dependências:

```bash
cd web-panel
npm install
```

## 📂 Estrutura do Projeto

```
Minecraft-Server-Termux/
├── install.sh              # Script de instalação
├── start.sh               # Inicia servidor e painel
├── setup-tunnel.sh        # Configura túnel público
├── bedrock-server/        # Arquivos do servidor Minecraft
│   ├── bedrock_server     # Executável do servidor
│   ├── server.properties  # Configurações do servidor
│   └── worlds/            # Mundos salvos
├── web-panel/             # Painel web
│   ├── server.js          # Backend Node.js
│   ├── package.json       # Dependências
│   └── public/            # Frontend
│       ├── index.html     # Interface
│       ├── style.css      # Estilos
│       └── script.js      # Lógica do cliente
└── README.md              # Este arquivo
```

## 🔒 Segurança

- O túnel Cloudflare é seguro e criptografado
- Recomenda-se usar senha no servidor para jogadores
- Configure whitelist em `server.properties` se necessário:

```
white-list=true
```

Depois adicione jogadores no console:

```
whitelist add nome_do_jogador
```

## 🌟 Recursos Adicionais

### Fazer Backup Automático

Baixe o mundo atual clicando em **"💾 Baixar Mundo Atual"** no painel.

### Múltiplos Mundos

Você pode manter múltiplos mundos na pasta `bedrock-server/worlds/` e alternar entre eles editando `server.properties`:

```
level-name=nome_do_mundo
```

### Mods e Add-ons

Adicione packs de comportamento e recursos na pasta:
- `bedrock-server/behavior_packs/`
- `bedrock-server/resource_packs/`

Configure-os em `server.properties`.

## 📱 Manter Servidor Rodando

### Usar Termux em Background

Para manter o servidor rodando quando fechar o Termux:

1. Instale o plugin Termux:Boot (opcional)
2. Use `screen` ou `tmux`:

```bash
pkg install screen
screen -S minecraft
./start.sh
```

Para desanexar: `Ctrl + A`, depois `D`

Para retornar: `screen -r minecraft`

### Wake Lock

Ative o "Acquire wakelock" nas configurações do Termux para evitar que o Android mate o processo.

## 🆘 Suporte

Problemas ou dúvidas? Abra uma issue no GitHub!

## 📄 Licença

MIT License - Use livremente!

## 🤝 Contribuições

Pull requests são bem-vindos! Para mudanças grandes, abra uma issue primeiro.

---

**Desenvolvido para a comunidade Minecraft Bedrock** ❤️

Divirta-se jogando! 🎮✨
