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
- Conexão com internet estável

## 📚 Documentação

- **README.md** - Documentação completa (este arquivo)
- **QUICK_START.md** - Guia rápido para começar
- **ATERNOS_GUIDE.md** - Como importar mundos do Aternos
- **TROUBLESHOOTING_DNS.md** - Soluções para problemas de download/DNS

## 🚀 Instalação

### ⚠️ IMPORTANTE: Siga os passos na ordem!

### 1. Clone o repositório

```bash
pkg install git
git clone https://github.com/deivid22srk/Minecraft-Server-Termux.git
cd Minecraft-Server-Termux
```

### 2. Dê permissões aos scripts

```bash
chmod +x *.sh
```

### 3. Execute a instalação (OBRIGATÓRIO NA PRIMEIRA VEZ)

```bash
./install.sh
```

⏱️ **Tempo estimado:** 10-15 minutos

A instalação irá:
- ✅ Atualizar os pacotes do Termux
- ✅ Instalar todas as dependências necessárias
- ✅ Baixar o servidor Bedrock
- ✅ Configurar o painel web
- ✅ Instalar o Cloudflare Tunnel

**⚠️ Aguarde a instalação terminar completamente antes de iniciar o servidor!**

## 🎯 Como Usar

### ✅ Primeiro Uso - Lista de Verificação

Antes de iniciar, certifique-se de:
- ✅ Executou `./install.sh` e aguardou terminar
- ✅ Viu a mensagem "Instalação concluída!"
- ✅ Está no diretório correto (`~/Minecraft-Server-Termux`)

### 🚀 Iniciar o Servidor

```bash
./start.sh
```

**⏱️ Aguarde 1-2 minutos** para tudo iniciar completamente.

Este comando irá:
1. ✅ Limpar processos antigos
2. ✅ Verificar dependências
3. ✅ Iniciar o painel web na porta 3000
4. ✅ Configurar os túneis públicos
5. ✅ Iniciar o servidor Minecraft

### 🛑 Parar o Servidor

**Opção 1:** Pressione `Ctrl+C` no terminal do servidor

**Opção 2:** Execute em outro terminal:
```bash
./stop.sh
```

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

### ❌ Erro: "bedrock_server: No such file or directory"

**Causa:** Servidor não foi instalado ou instalação incompleta

**Solução:**
```bash
./install.sh
```
Aguarde a mensagem "Instalação concluída!"

---

### ❌ Erro: "failed: No address associated with hostname"

**Causa:** Problema de DNS no Termux - não consegue resolver nomes de domínio

Este é o erro mais comum e pode acontecer por:
- DNS do Termux não configurado corretamente
- Conflito com VPN
- Problemas com a rede WiFi atual

**Solução Passo a Passo:**

**1️⃣ Corrigir DNS (RECOMENDADO):**
```bash
./fix-dns.sh
```

**2️⃣ Trocar repositório do Termux:**
```bash
termux-change-repo
```
Escolha um mirror mais próximo (ex: Albatross, Grimler)

**3️⃣ Usar download manual:**
```bash
./download-server.sh
```
Este script tem mais URLs alternativas e melhor tratamento de erros.

**4️⃣ Se continuar falhando:**
- Desconecte VPN se estiver usando
- Troque de rede WiFi
- Use dados móveis em vez de WiFi
- Reinicie o Termux completamente

**5️⃣ Download manual no PC (último recurso):**
1. No PC, baixe: https://www.minecraft.net/en-us/download/server/bedrock
2. Escolha "Linux (Ubuntu)" version
3. Transfira o arquivo .zip para o Android
4. No Termux:
```bash
mkdir -p ~/Minecraft-Server-Termux/bedrock-server
cd ~/Minecraft-Server-Termux/bedrock-server
unzip ~/caminho/para/bedrock-server.zip
chmod +x bedrock_server
```

---

### ❌ Erro: "Port 3000 already in use"

**Causa:** Processo anterior ainda está rodando na porta 3000

**Solução:**
```bash
./stop.sh
sleep 3
./start.sh
```

Ou manualmente:
```bash
pkill -f "node server.js"
pkill -f bedrock_server
pkill -f cloudflared
./start.sh
```

---

### ❌ URLs públicas não aparecem

**Causa:** Cloudflare Tunnel ainda está conectando

**Solução 1:** Aguarde 1-2 minutos

**Solução 2:** Verifique os arquivos:
```bash
cat web-url.txt
cat mc-url.txt
```

**Solução 3:** Reinicie o túnel:
```bash
pkill -f cloudflared
./setup-tunnel.sh
```

---

### ❌ Painel web não abre

**Causa 1:** Dependências do Node.js não instaladas

**Solução:**
```bash
cd web-panel
npm install
cd ..
./start.sh
```

**Causa 2:** Porta 3000 bloqueada

**Solução:**
```bash
./stop.sh
./start.sh
```

---

### ❌ Não consigo conectar no Minecraft

**Verificações:**
1. ✅ Servidor está rodando? (veja logs no console)
2. ✅ Aguardou 2 minutos após iniciar?
3. ✅ Porta correta? (deve ser 19132)
4. ✅ Endereço correto? (copie do painel web)

**Solução:**
```bash
./stop.sh
sleep 5
./start.sh
```

Aguarde a mensagem com as URLs públicas.

---

### ❌ Servidor fecha sozinho

**Causa:** Memória insuficiente ou erro no servidor

**Solução:** Verifique os logs:
```bash
cat bedrock-server/logs/latest.log
```

Se for falta de memória:
- Feche outros apps no Android
- Reduza a distância de renderização no painel
- Reduza o máximo de jogadores

---

### ❌ Mundo não importa do Aternos

**Verificações:**
1. ✅ Arquivo é .zip ou .mcworld?
2. ✅ Servidor está parado?
3. ✅ Tem espaço em disco?

**Solução:**
```bash
./stop.sh
```

Depois importe pelo painel web.

Verifique erros:
```bash
tail -f web-panel.log
```

---

### ❌ Game Rules não aplicam

**Causa:** Servidor não está rodando

**Solução:**
Game rules só podem ser aplicadas com servidor RODANDO!

1. Certifique-se que o status é "Rodando"
2. Configure as opções
3. Clique em "Aplicar Game Rules"

---

### 🔄 Reinstalação Limpa

Se nada funcionar, reinstale tudo:

```bash
cd ~
rm -rf Minecraft-Server-Termux
git clone https://github.com/deivid22srk/Minecraft-Server-Termux.git
cd Minecraft-Server-Termux
chmod +x *.sh
./install.sh
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
