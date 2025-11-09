# 🚀 GUIA RÁPIDO DE INÍCIO

## 🎯 Sistema: PocketMine-MP (Nativo ARM64)

Este servidor usa **PocketMine-MP** que roda **nativamente** em dispositivos ARM64 (Android) sem emulação!

---

## ⚡ Setup em 3 Passos

### 1️⃣ Instalar (Primeira vez apenas)
```bash
cd Minecraft-Server-Termux
chmod +x *.sh
./install.sh
```
**⏱️ Aguarde 15-25 minutos** (PHP será compilado)

**O que será instalado:**
- Ferramentas de compilação (make, clang, gcc, etc.)
- PocketMine-MP 5.37.0+
- PHP 8.2+ com extensões customizadas
- Node.js para painel web
- Cloudflare Tunnel

**⚠️ NÃO INTERROMPA A COMPILAÇÃO DO PHP!**
- Pode demorar 10-20 minutos
- Mantenha na energia
- Feche outros apps
- Aguarde a mensagem "Instalação concluída!"

---

### 2️⃣ Iniciar Servidor
```bash
./start.sh
```
**⏱️ Aguarde 1-2 minutos para iniciar completamente**

Você verá algo como:
```
==========================================
  🌐 URLS PÚBLICAS
==========================================

🌐 Painel Web: https://xxx.trycloudflare.com
🎮 Porta Minecraft: 19132
```

---

### 3️⃣ Acessar Painel Web
Abra a URL exibida no navegador (ex: `https://xxx.trycloudflare.com`)

---

## 🎮 Conectar no Minecraft

1. Abra **Minecraft Bedrock Edition** (versão 1.21.120+)
2. Vá em **Jogar** → **Servidores** → **Adicionar Servidor**
3. Use as informações:
   - **Nome:** Qualquer nome
   - **Endereço:** (pegar no painel web)
   - **Porta:** `19132`

---

## 🛑 Parar Servidor

**Opção 1:** Pressione `Ctrl+C` no terminal

**Opção 2:** Em outro terminal:
```bash
./stop.sh
```

---

## ❌ Problemas?

### Erro: "Servidor não encontrado"
**Causa:** Você não executou o `./install.sh` ainda

**Solução:**
```bash
./install.sh
```

---

### Erro: "Port 3000 already in use"
**Solução:**
```bash
./stop.sh
sleep 3
./start.sh
```

---

### Servidor não mostra URLs públicas
**Solução:** Aguarde mais 1-2 minutos ou verifique:
```bash
cat web-url.txt
```

---

### Não consigo me conectar no Minecraft
**Soluções:**
1. Aguarde 2 minutos após iniciar
2. Use porta 19132
3. Verifique se sua versão do Minecraft é 1.21.120 ou próxima
4. Reinicie: `./stop.sh && ./start.sh`

---

## ⚙️ Ativar Coordenadas e KeepInventory

1. Acesse o painel web
2. Role até **"🎯 Configurações Rápidas"**
3. Marque as opções:
   - ✅ Mostrar Coordenadas
   - ✅ Manter Inventário ao Morrer
4. Clique em **"Aplicar Game Rules"**

**⚠️ O servidor precisa estar RODANDO para aplicar game rules!**

---

## 📥 Importar Mundo do Aternos

1. Baixe seu mundo do [Aternos](https://aternos.org) (arquivo .zip)
2. **PARE o servidor:** `./stop.sh`
3. Acesse o painel web
4. Vá em **"📥 Importar do Aternos"**
5. Escolha o arquivo .zip
6. Clique em **"📤 Importar Mundo"**
7. Aguarde a conclusão
8. Inicie o servidor: `./start.sh`

---

## 🔌 Instalar Plugins

1. Visite [Poggit](https://poggit.pmmp.io/)
2. Baixe plugins `.phar`
3. Via painel web ou Termux:
```bash
cp plugin.phar ~/Minecraft-Server-Termux/pocketmine-server/plugins/
```
4. Reinicie o servidor

---

## 🔧 Manutenção

### Fazer Backup
No painel web → **"💾 Baixar Mundo Atual"**

### Ver Logs
```bash
tail -f pocketmine-server/server.log
```

### Atualizar PocketMine-MP
```bash
cd pocketmine-server
curl -sL https://get.pmmp.io | bash -s -
```

---

## 📋 Comandos Úteis

```bash
./help.sh          # Ver este guia
./start.sh         # Iniciar servidor
./stop.sh          # Parar servidor
./commands.sh      # Menu interativo
./install.sh       # Reinstalar/atualizar
```

---

## 💡 Vantagens do PocketMine-MP

✅ **Nativo ARM64** - Performance superior  
✅ **Sem emulação** - Mais estável e rápido  
✅ **Plugins** - Extensível com milhares de plugins  
✅ **Compatível** - Funciona com Bedrock oficial  
✅ **Leve** - Usa menos recursos que servidor oficial  

---

## 🆘 Suporte

1. Leia o `README.md` completo
2. Verifique `ATERNOS_GUIDE.md` para importação
3. Execute `./help.sh` para dicas
4. Abra uma issue no GitHub

---

**🎮 Divirta-se jogando!** ✨

**Compatível com Minecraft Bedrock 1.21.120+**
