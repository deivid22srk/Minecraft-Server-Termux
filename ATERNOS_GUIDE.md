# 📥 Guia Completo: Como Importar Seu Mundo do Aternos

Este guia mostra passo a passo como transferir seu mundo do Aternos para seu servidor **PocketMine-MP** no Termux.

## 🎯 Sobre Compatibilidade

Este servidor usa **PocketMine-MP** (ARM64 nativo) em vez do servidor oficial:

✅ **O que funciona:**
- Blocos e construções
- Inventários de jogadores
- Cofres e itens
- Estrutura do mundo
- Maioria das entidades

⚠️ **Possíveis limitações:**
- Command blocks muito complexos podem precisar de ajuste
- Algumas mecânicas específicas podem diferir
- Mods do servidor oficial podem não funcionar

💡 **Mas não se preocupe!** A grande maioria dos mundos funciona perfeitamente, e você pode usar plugins PocketMine-MP para adicionar funcionalidades extras!

## 🎯 Pré-requisitos

- Conta no [Aternos](https://aternos.org)
- Servidor criado no Aternos com um mundo salvo
- Seu servidor Bedrock instalado no Termux
- Acesso ao painel web

## 📋 Passo 1: Preparar o Servidor no Aternos

### 1.1 Acesse seu servidor

1. Faça login no [Aternos](https://aternos.org)
2. Selecione seu servidor na lista
3. **NÃO precisa iniciar o servidor** - pode estar parado

### 1.2 Verifique o tipo do servidor

⚠️ **IMPORTANTE:** Este método funciona melhor com servidores Bedrock.

Se seu servidor for Java Edition:
- Os mundos Java não são diretamente compatíveis com Bedrock
- Você precisará usar ferramentas de conversão externas
- Recomendamos começar um novo mundo diretamente no Bedrock

## 📦 Passo 2: Baixar o Mundo do Aternos

### 2.1 Navegue até a seção de mundos

1. No painel do Aternos, clique em **"Worlds"** (ícone de globo) no menu lateral
2. Você verá uma lista de todos os mundos salvos

### 2.2 Selecione o mundo

1. Encontre o mundo que deseja exportar
2. Ele geralmente terá um nome como "world" ou o nome personalizado que você deu

### 2.3 Faça o download

1. Clique no botão **"Download"** (ícone de seta para baixo) ao lado do mundo
2. O download começará automaticamente
3. O arquivo será baixado como **`.zip`** ou **`.mcworld`**
4. Anote onde o arquivo foi salvo no seu dispositivo

### 2.4 Alternativa: Baixar via FTP (Avançado)

Se o download direto não funcionar:

1. Vá em **"Files"** no painel do Aternos
2. Navegue até a pasta **"worlds"**
3. Baixe a pasta do mundo completa
4. Compacte em um arquivo .zip

## 📱 Passo 3: Transferir o Arquivo para o Dispositivo com Termux

Existem várias formas de fazer isso:

### Opção A: Download Direto no Android

1. Baixe o mundo diretamente no navegador do Android
2. O arquivo ficará em `Downloads/`
3. Prossiga para o Passo 4

### Opção B: Transferir via USB

1. Conecte o dispositivo Android ao PC via USB
2. Copie o arquivo .zip para o dispositivo
3. Coloque em uma pasta fácil de acessar (Downloads, Documents, etc.)

### Opção C: Usar Cloud Storage

1. Faça upload do arquivo para Google Drive, Dropbox, etc.
2. Baixe no dispositivo Android usando o app correspondente

### Opção D: Usar Termux diretamente (Avançado)

Se você tiver a URL de download:

```bash
cd ~/storage/downloads
wget "URL_DO_ARQUIVO" -O mundo-aternos.zip
```

## 🌐 Passo 4: Importar pelo Painel Web

### 4.1 Acesse o painel web

1. Inicie seu servidor Bedrock no Termux:
   ```bash
   ./start.sh
   ```

2. Anote a URL do painel web exibida no console:
   ```
   🌐 Painel Web: https://xxx.trycloudflare.com
   ```

3. Abra essa URL no navegador

### 4.2 Pare o servidor (se estiver rodando)

1. No painel, clique em **"⏹️ Parar"**
2. Aguarde até o status mudar para "Parado"

⚠️ **IMPORTANTE:** O servidor deve estar parado para importar o mundo!

### 4.3 Faça o upload do mundo

1. Role até a seção **"📥 Importar do Aternos"**
2. Clique em **"Escolher arquivo"**
3. Navegue até onde salvou o arquivo .zip do Aternos
4. Selecione o arquivo
5. Clique em **"📤 Importar Mundo"**

### 4.4 Aguarde a importação

- Uma mensagem aparecerá: "Importando mundo... Isso pode levar alguns minutos."
- **NÃO feche o navegador durante este processo**
- Tempo estimado: 2-5 minutos (depende do tamanho do mundo)
- Você verá uma confirmação quando terminar

### 4.5 Inicie o servidor

1. Clique em **"▶️ Iniciar"**
2. Aguarde o servidor iniciar
3. Verifique os logs no console para confirmar

## ✅ Passo 5: Verificar se Funcionou

### 5.1 Conectar ao servidor

1. Abra Minecraft Bedrock no dispositivo
2. Vá em **"Jogar"** → **"Servidores"** → **"Adicionar Servidor"**
3. Use o endereço mostrado no painel web
4. Conecte-se

### 5.2 Verificar o mundo

1. Ao entrar, você deve estar no mundo importado do Aternos
2. Verifique se suas construções estão lá
3. Verifique o inventário dos jogadores
4. Teste se tudo está funcionando

## 🔧 Solução de Problemas

### ❌ Erro: "Nenhum arquivo enviado"

**Causa:** O arquivo não foi selecionado corretamente

**Solução:**
1. Certifique-se de clicar em "Escolher arquivo"
2. Selecione o arquivo .zip
3. Aguarde o nome do arquivo aparecer
4. Então clique em "Importar"

### ❌ Erro: "Erro ao extrair mundo"

**Causa:** O arquivo pode estar corrompido ou em formato incorreto

**Solução:**
1. Verifique se o arquivo é .zip ou .mcworld
2. Tente baixar o mundo do Aternos novamente
3. Verifique se o arquivo não está vazio
4. Tente descompactar o arquivo manualmente para testar

### ❌ O mundo está vazio ou diferente

**Causa:** Pode ser um mundo diferente ou conversão incorreta

**Solução:**
1. Verifique se baixou o mundo correto no Aternos
2. Confirme que é um mundo Bedrock, não Java
3. Tente importar novamente
4. Verifique os backups no Aternos

### ❌ Servidor não inicia após importar

**Causa:** Possível corrupção de arquivos do mundo

**Solução:**
1. Verifique os logs no console do painel
2. Restaure um backup anterior:
   ```bash
   cd bedrock-server
   rm -rf worlds
   mv worlds_backup/backup_XXXXX worlds
   ```
3. Tente importar novamente com servidor parado

### ❌ Jogadores não aparecem no mundo

**Causa:** Aternos pode ter salvado dados de jogadores separadamente

**Solução:**
1. No Aternos, baixe também a pasta "players" se disponível
2. Copie manualmente para `bedrock-server/worlds/SeuMundo/players/`

## 💾 Fazer Backup Antes de Importar

**Recomendado:** Sempre faça backup do mundo atual antes de importar:

1. No painel web, clique em **"💾 Baixar Mundo Atual"**
2. Salve o arquivo em local seguro
3. Depois prossiga com a importação

Assim você pode restaurar se algo der errado!

## 🔄 Importar Múltiplos Mundos

Você pode ter múltiplos mundos e alternar entre eles:

### Método 1: Via Painel Web

1. Importe o primeiro mundo normalmente
2. Renomeie a pasta em `bedrock-server/worlds/` via Termux
3. Importe o segundo mundo
4. Alterne editando `level-name` em `server.properties`

### Método 2: Via Termux

```bash
cd bedrock-server/worlds
mv "Bedrock level" mundo1
mv "NomeDoOutroMundo" mundo2

cd ..
nano server.properties
```

Mude:
```
level-name=mundo1
```

ou

```
level-name=mundo2
```

## 📋 Checklist Rápido

Antes de importar, certifique-se:

- ✅ Mundo baixado do Aternos em formato .zip ou .mcworld
- ✅ Servidor Bedrock parado
- ✅ Backup do mundo atual feito (se existir)
- ✅ Espaço suficiente em disco
- ✅ Painel web acessível
- ✅ Conexão com internet estável

## 🎮 Configurar o Mundo Importado

Após importar com sucesso, você pode configurar:

### Game Rules no Painel Web

- Mostrar coordenadas
- Manter inventário ao morrer
- PvP
- Fogo amigo

### Server Properties

- Dificuldade
- Modo de jogo padrão
- Máximo de jogadores
- Distância de renderização

## 🆘 Ainda com Problemas?

Se nada disso resolver:

1. **Verifique os logs:**
   ```bash
   cd ~/Minecraft-Server-Termux
   cat bedrock-server/logs/latest.log
   ```

2. **Teste o arquivo do mundo:**
   ```bash
   cd ~/storage/downloads
   unzip -t mundo-aternos.zip
   ```

3. **Reinstale o servidor:**
   ```bash
   cd ~/Minecraft-Server-Termux
   rm -rf bedrock-server
   ./install.sh
   ```

4. **Abra uma issue no GitHub** com:
   - Descrição do problema
   - Mensagens de erro
   - Passos que você seguiu

---

**Boa sorte com seu servidor! 🎮✨**

Agora você pode continuar suas aventuras do Aternos no seu próprio servidor Bedrock!
