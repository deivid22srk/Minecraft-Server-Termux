# 🔧 Solução de Problemas - PocketMine-MP

## ❓ Por que PocketMine-MP em vez do servidor oficial?

### ❌ Servidor Oficial Bedrock:
- Só funciona em x86_64 (Intel/AMD)
- **NÃO funciona nativamente em ARM64** (Android)
- Requer emulação (Box64) que é lenta e instável
- Performance ruim em dispositivos móveis

### ✅ PocketMine-MP:
- Funciona **nativamente em ARM64** (Android)
- **Sem emulação** - muito mais rápido
- Escrito em PHP (multiplataforma)
- Compatível com Minecraft Bedrock 1.21.120+
- Suporta plugins para estender funcionalidades

---

## 🔍 Problemas Comuns

### ❌ Erro: "PHP not found"

**Causa:** PHP não está instalado

**Solução:**
```bash
pkg install php
php -v
```

Deve mostrar PHP 8.2 ou superior.

---

### ❌ Erro ao instalar PocketMine-MP

**Causa:** Problema no download do instalador

**Solução Manual:**
```bash
cd ~/Minecraft-Server-Termux
mkdir -p pocketmine-server
cd pocketmine-server

wget -O - https://get.pmmp.io | bash -s -
```

Ou com curl:
```bash
curl -sL https://get.pmmp.io | bash -s -
```

---

### ❌ "Could not find PocketMine-MP.phar"

**Causa:** Instalação incompleta

**Solução:**
```bash
cd ~/Minecraft-Server-Termux/pocketmine-server
curl -sL https://get.pmmp.io | bash -s -
chmod +x start.sh
```

---

### ❌ Incompatibilidade de versão do Minecraft

**Sintomas:** Jogadores não conseguem se conectar, erro de versão

**Causa:** PocketMine-MP pode precisar de atualização para versões mais novas do Minecraft

**Solução:**
```bash
cd ~/Minecraft-Server-Termux/pocketmine-server
./start.sh --update
```

Ou reinstale:
```bash
curl -sL https://get.pmmp.io | bash -s -
```

---

### ❌ Mundo do Aternos não carrega corretamente

**Causa:** PocketMine-MP e servidor oficial têm algumas diferenças

**O que funciona:**
- ✅ Blocos e construções
- ✅ Inventários de jogadores
- ✅ Cofres e itens
- ✅ Estrutura do mundo

**O que pode precisar de ajuste:**
- ⚠️ Algumas entidades específicas
- ⚠️ Command blocks complexos
- ⚠️ Redstone muito avançado

**Solução:**
1. Faça backup antes de importar
2. Teste o mundo após importar
3. Use plugins para adicionar funcionalidades faltantes

---

### ❌ Performance ruim / Lag

**Causas possíveis:**
- Muitos jogadores
- Mundo muito grande
- Plugins pesados
- Pouca RAM disponível

**Soluções:**

**1. Otimizar server.properties:**
```bash
cd pocketmine-server
nano server.properties
```

Ajuste:
```
view-distance=8
max-players=10
```

**2. Liberar memória:**
- Feche outros apps no Android
- Reinicie o Termux

**3. Desativar plugins pesados:**
```bash
cd pocketmine-server/plugins
mv plugin.phar plugin.phar.disabled
```

---

### ❌ Servidor fecha sozinho

**Causa 1:** Memória insuficiente

**Solução:** Reduza a RAM alocada:
```bash
cd pocketmine-server
nano start.sh
```

Procure a linha com `php` e ajuste `-Xmx` e `-Xms`.

**Causa 2:** Erro no servidor

**Solução:** Verifique os logs:
```bash
cat pocketmine-server/server.log
tail -f pocketmine-server/server.log
```

---

### ❌ Game Rules não aplicam

**Causa:** Sintaxe diferente ou servidor não suporta alguns gamerules

**Solução:** Use comandos PocketMine-MP:

Via console do painel:
```
gamerule keepInventory true
gamerule showcoordinates true
gamerule pvp true
```

Ou edite `pocketmine.yml`:
```bash
cd pocketmine-server
nano pocketmine.yml
```

---

### ❌ Jogadores com versão incompatível

**Causa:** PocketMine-MP suporta versões específicas do Bedrock

**Verificar versão suportada:**
```bash
cd pocketmine-server
./start.sh --version
```

**Atualizar PocketMine-MP:**
```bash
cd pocketmine-server
curl -sL https://get.pmmp.io | bash -s -
```

**Dica:** Mantenha seu Minecraft Bedrock atualizado para a versão mais recente.

---

## 🔌 Problemas com Plugins

### Plugin não carrega

**Solução:**
1. Verifique compatibilidade: `pocketmine-server/plugins/PluginName/plugin.yml`
2. Veja logs: `cat pocketmine-server/server.log | grep -i plugin`
3. Atualize o plugin para versão compatível

### Conflito entre plugins

**Solução:**
1. Desative plugins um por um
2. Identifique qual está causando conflito
3. Remova ou atualize

---

## 📊 Diagnóstico Completo

### Teste 1: PHP funciona?
```bash
php -v
```
Deve mostrar PHP 8.2+

### Teste 2: PocketMine-MP instalado?
```bash
ls -la ~/Minecraft-Server-Termux/pocketmine-server/
```
Deve ter: `start.sh`, `PocketMine-MP.phar`

### Teste 3: Servidor inicia manualmente?
```bash
cd ~/Minecraft-Server-Termux/pocketmine-server
./start.sh
```

### Teste 4: Painel web funciona?
```bash
cd ~/Minecraft-Server-Termux/web-panel
node server.js
```

---

## 🆘 Ainda com Problemas?

### Reinstalação completa:

```bash
cd ~
rm -rf Minecraft-Server-Termux
git clone https://github.com/deivid22srk/Minecraft-Server-Termux.git
cd Minecraft-Server-Termux
chmod +x *.sh
./install.sh
```

### Suporte Adicional:

- [Documentação PocketMine-MP](https://doc.pmmp.io/)
- [Discord PocketMine-MP](https://discord.gg/bmSAZBG)
- [Forum PocketMine](https://forums.pmmp.io/)
- [Issues GitHub](https://github.com/deivid22srk/Minecraft-Server-Termux/issues)

---

## 📚 Recursos Úteis

- **Plugins:** https://poggit.pmmp.io/
- **Documentação:** https://doc.pmmp.io/
- **GitHub:** https://github.com/pmmp/PocketMine-MP

---

**🎮 PocketMine-MP é a melhor escolha para servidores Bedrock em Android!** ✨
