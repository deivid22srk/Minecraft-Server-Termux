# 🚀 GUIA RÁPIDO DE INÍCIO

## ⚡ Setup em 3 Passos

### 1️⃣ Instalar (Primeira vez apenas)
```bash
cd Minecraft-Server-Termux
chmod +x *.sh
./install.sh
```
**⏱️ Aguarde 10-15 minutos**

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

## 🛑 Parar Servidor

**Opção 1:** Pressione `Ctrl+C` no terminal

**Opção 2:** Em outro terminal:
```bash
./stop.sh
```

---

## 🎮 Conectar no Minecraft

1. Abra **Minecraft Bedrock Edition**
2. Vá em **Jogar** → **Servidores** → **Adicionar Servidor**
3. Use as informações:
   - **Nome:** Qualquer nome
   - **Endereço:** (pegar no painel web ou logs)
   - **Porta:** `19132`

---

## ❌ Problemas?

### Erro: "bedrock_server: No such file or directory"
**Causa:** Você não executou o `./install.sh` ainda

**Solução:**
```bash
./install.sh
```

---

### Erro: "Port 3000 already in use"
**Causa:** O servidor anterior não foi fechado corretamente

**Solução:**
```bash
./stop.sh
sleep 3
./start.sh
```

---

### Servidor não aparece URLs públicas
**Causa:** O túnel ainda está conectando

**Solução:**
- Aguarde mais 1-2 minutos
- Verifique o arquivo `web-url.txt`
```bash
cat web-url.txt
```

---

### Não consigo me conectar no Minecraft
**Causas possíveis:**
1. Servidor ainda está iniciando (aguarde 2 minutos)
2. Porta incorreta (use 19132)
3. Túnel não conectou (reinicie)

**Solução:**
```bash
./stop.sh
sleep 5
./start.sh
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

**📖 Ver guia completo:** `ATERNOS_GUIDE.md`

---

## 🔧 Manutenção

### Fazer Backup do Mundo
No painel web → **"💾 Baixar Mundo Atual"**

### Ver Logs
```bash
tail -f bedrock-server/logs/latest.log
```

### Verificar Processos
```bash
ps aux | grep -E 'bedrock|node|cloudflared'
```

---

## 🆘 Suporte

1. Leia o `README.md` completo
2. Verifique `ATERNOS_GUIDE.md` para importação
3. Execute `./help.sh` para dicas
4. Abra uma issue no GitHub

---

**🎮 Divirta-se jogando!** ✨
