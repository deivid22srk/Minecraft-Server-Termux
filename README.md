# 🎮 Minecraft Bedrock Server para Termux

Servidor completo de Minecraft Bedrock Edition usando **PocketMine-MP** (nativo ARM64) com painel web de gerenciamento, acesso público via túnel e importação de mundos do Aternos.

## ⚡ Por que PocketMine-MP?

Este projeto usa **PocketMine-MP** em vez do servidor oficial da Minecraft porque:

- ✅ **Nativo em ARM64** - Roda perfeitamente em dispositivos Android sem emulação
- ✅ **Performance Superior** - Muito mais rápido que emuladores (Box64, QEMU)
- ✅ **Compatível** - Suporta Minecraft Bedrock 1.21.120+
- ✅ **Open Source** - Código aberto e constantemente atualizado
- ✅ **Plugins** - Extensível com milhares de plugins disponíveis
- ✅ **Estável** - Usado por milhões de servidores ao redor do mundo

> ⚠️ **Nota:** O servidor oficial Bedrock da Microsoft só funciona em x86_64 (Intel/AMD). Em dispositivos ARM (Android), você precisaria de emulação que é lenta e instável. PocketMine-MP resolve isso!

## ✨ Características

- ✅ Servidor Minecraft Bedrock 1.21.120+ nativo ARM64
- 🌐 Painel web completo para gerenciamento
- 🔓 Acesso público via Cloudflare Tunnel (não é localhost!)
- 📥 Importação de mundos do Aternos
- ⚙️ Configurações em tempo real (coordenadas, keepInventory, etc.)
- 💬 Console ao vivo com logs em tempo real
- 📊 Controle total do servidor (iniciar, parar, reiniciar)
- 🎯 Game rules configuráveis pela interface
- 💾 Backup e download de mundos
- 🔌 Suporte a plugins PocketMine-MP

## 📋 Requisitos

- Android com Termux instalado
- Pelo menos 2GB de RAM disponível
- Espaço de armazenamento: ~300MB
- Conexão com internet estável
- **Qualquer dispositivo ARM64** (maioria dos Androids modernos)

## 📚 Documentação

- **README.md** - Documentação completa (este arquivo)
- **QUICK_START.md** - Guia rápido para começar
- **ATERNOS_GUIDE.md** - Como importar mundos do Aternos
- **TROUBLESHOOTING.md** - Soluções para problemas comuns

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

⏱️ **Tempo estimado:** 5-10 minutos

A instalação irá:
- ✅ Atualizar os pacotes do Termux
- ✅ Instalar PHP e dependências
- ✅ Baixar e instalar PocketMine-MP
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
5. ✅ Iniciar o servidor PocketMine-MP

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
🎮 Servidor Minecraft: porta 19132
```

**Acesse o painel web pelo navegador usando a URL exibida!**

## 🎮 Conectar ao Servidor

1. Abra Minecraft Bedrock no seu dispositivo
2. Vá em "Jogar" → "Servidores" → "Adicionar Servidor"
3. Use o endereço mostrado no painel web
4. Porta: 19132

**Importante:** Qualquer pessoa com o endereço pode se conectar de qualquer rede WiFi!

## 📥 Importar Mundo do Aternos

### Compatibilidade

⚠️ **Mundos do Aternos são compatíveis**, mas considere:

- ✅ Mundos pequenos e médios: funcionam perfeitamente
- ✅ Construções e blocos: preservados
- ⚠️ Algumas entidades ou mecânicas específicas podem precisar de ajustes
- ✅ Inventários de jogadores: preservados

### Passos para Importar:

1. Baixe seu mundo do [Aternos](https://aternos.org)
2. Pare o servidor: `./stop.sh`
3. Acesse o painel web
4. Vá em "📥 Importar do Aternos"
5. Faça upload do arquivo .zip
6. Aguarde a importação
7. Inicie o servidor: `./start.sh`

📖 **Ver guia completo:** `ATERNOS_GUIDE.md`

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

## 🔌 Plugins PocketMine-MP

PocketMine-MP suporta plugins! Você pode adicionar funcionalidades extras:

### Onde Encontrar Plugins:

- [Poggit](https://poggit.pmmp.io/) - Repositório oficial de plugins

### Como Instalar Plugins:

1. Baixe o arquivo `.phar` do plugin
2. Copie para `pocketmine-server/plugins/`
3. Reinicie o servidor

### Plugins Recomendados:

- **EssentialsPE** - Comandos úteis (/home, /warp, etc.)
- **WorldEdit** - Edição de mundo
- **EconomyAPI** - Sistema de economia
- **PurePerms** - Sistema de permissões

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
gamerule keepInventory true  # Manter inventário
gamerule showcoordinates true # Mostrar coordenadas
```

## 🔧 Solução de Problemas

### ❌ Erro: "Servidor não encontrado"

**Causa:** PocketMine-MP não foi instalado

**Solução:**
```bash
./install.sh
```
Aguarde a mensagem "Instalação concluída!"

---

### ❌ Erro: "Port 3000 already in use"

**Solução:**
```bash
./stop.sh
sleep 3
./start.sh
```

---

### ❌ Servidor não inicia

**Verificações:**

1. PHP instalado?
```bash
php -v
```

2. PocketMine-MP baixado?
```bash
ls -la pocketmine-server/
```

3. Verificar logs:
```bash
cat pocketmine-server/server.log
```

---

### ❌ Não consigo conectar no Minecraft

**Verificações:**
1. ✅ Servidor está rodando?
2. ✅ Aguardou 2 minutos após iniciar?
3. ✅ Porta correta? (19132)
4. ✅ Versão compatível? (Bedrock 1.21.120+)

**Solução:**
```bash
./stop.sh
sleep 5
./start.sh
```

---

### ❌ Incompatibilidade de versão

**Causa:** Seu Minecraft Bedrock está em versão diferente

**Solução:** PocketMine-MP geralmente suporta múltiplas versões, mas verifique:

```bash
cd pocketmine-server
./start.sh --version
```

Atualize PocketMine-MP:
```bash
cd pocketmine-server
curl -sL https://get.pmmp.io | bash -s -
```

---

### 🔄 Reinstalação Limpa

Se nada funcionar:

```bash
cd ~
rm -rf Minecraft-Server-Termux
git clone https://github.com/deivid22srk/Minecraft-Server-Termux.git
cd Minecraft-Server-Termux
chmod +x *.sh
./install.sh
```

## 📁 Estrutura do Projeto

```
Minecraft-Server-Termux/
├── install.sh              # Script de instalação
├── start.sh                # Inicia servidor e painel
├── stop.sh                 # Para todos os processos
├── setup-tunnel.sh         # Configura túnel público
├── help.sh                 # Ajuda rápida
├── commands.sh             # Menu interativo
├── pocketmine-server/      # PocketMine-MP
│   ├── start.sh            # Iniciar PocketMine
│   ├── PocketMine-MP.phar  # Servidor
│   ├── server.properties   # Configurações
│   ├── worlds/             # Mundos salvos
│   └── plugins/            # Plugins instalados
├── web-panel/              # Painel web
│   ├── server.js           # Backend Node.js
│   ├── package.json        # Dependências
│   └── public/             # Frontend
│       ├── index.html      # Interface
│       ├── style.css       # Estilos
│       └── script.js       # Lógica do cliente
├── README.md               # Documentação completa
├── QUICK_START.md          # Guia rápido
└── ATERNOS_GUIDE.md        # Guia de importação
```

## 🔒 Segurança

- O túnel Cloudflare é seguro e criptografado
- Configure senha no `server.properties` se desejar
- Use whitelist para controlar acesso:

```bash
cd pocketmine-server
nano server.properties
```

Mude:
```
white-list=true
```

Adicione jogadores via console do painel.

## 🌟 Recursos Adicionais

### Fazer Backup Automático

Baixe o mundo atual clicando em **"💾 Baixar Mundo Atual"** no painel.

### Múltiplos Mundos

Você pode ter múltiplos mundos na pasta `pocketmine-server/worlds/` e alternar editando `server.properties`:

```
level-name=nome_do_mundo
```

### Adicionar Plugins

1. Visite [Poggit](https://poggit.pmmp.io/)
2. Baixe plugins `.phar`
3. Copie para `pocketmine-server/plugins/`
4. Reinicie o servidor

## 📱 Manter Servidor Rodando

### Usar Termux em Background

Para manter o servidor rodando quando fechar o Termux:

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

Problemas ou dúvidas? 

- [Issues no GitHub](https://github.com/deivid22srk/Minecraft-Server-Termux/issues)
- [Documentação PocketMine-MP](https://doc.pmmp.io/)
- [Discord PocketMine-MP](https://discord.gg/bmSAZBG)

## 📄 Licença

MIT License - Use livremente!

## 🙏 Créditos

- **PocketMine-MP** - Software do servidor
- **Cloudflare** - Túnel público gratuito
- **Comunidade Minecraft Bedrock** ❤️

---

**Desenvolvido para a comunidade Minecraft Bedrock** ❤️

Divirta-se jogando! 🎮✨
