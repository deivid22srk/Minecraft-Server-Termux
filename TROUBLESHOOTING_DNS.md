# 🔧 Soluções para Problemas de Download/DNS

## ❌ Problema: Download do Servidor Falha

Se você viu este erro durante `./install.sh`:
```
failed: No address associated with hostname
wget: unable to resolve host address 'minecraft.azureedge.net'
```

**Isso significa:** O Termux não consegue resolver nomes de domínio (problema de DNS).

---

## ✅ SOLUÇÃO 1: Corrigir DNS (MAIS RÁPIDO)

Execute o script de correção de DNS:

```bash
./fix-dns.sh
```

Este script:
- ✅ Configura DNS do Google (8.8.8.8 e 8.8.4.4)
- ✅ Testa a conexão
- ✅ Limpa cache

Depois tente instalar novamente:
```bash
./install.sh
```

---

## ✅ SOLUÇÃO 2: Download Manual Interativo

Use o script de download manual que tem mais opções:

```bash
./download-server.sh
```

Este script oferece:
- 📋 Menu com múltiplas versões do servidor
- 🔄 Múltiplas tentativas automáticas
- ✅ Verificação de integridade do arquivo
- 📊 Progresso detalhado do download

---

## ✅ SOLUÇÃO 3: Trocar Repositório do Termux

Às vezes o problema está no repositório do Termux:

```bash
termux-change-repo
```

**Escolha:**
- Use as setas para selecionar
- Escolha um mirror próximo da sua localização
- Exemplos: Albatross, Grimler, Kcubeterm

Depois:
```bash
pkg update
./install.sh
```

---

## ✅ SOLUÇÃO 4: Trocar de Rede

### Opção A: Usar Dados Móveis
1. Desligue o WiFi
2. Ative os dados móveis 4G/5G
3. Execute `./install.sh`

### Opção B: Trocar WiFi
1. Conecte em outra rede WiFi
2. Execute `./install.sh`

### Opção C: Desativar VPN
Se estiver usando VPN:
1. Desative a VPN
2. Execute `./install.sh`

---

## ✅ SOLUÇÃO 5: Download Manual no PC

Se nada funcionar, baixe no PC e transfira:

### No PC/Notebook:

1. Acesse: https://www.minecraft.net/en-us/download/server/bedrock
2. Clique em **"Download"** na seção Linux
3. Salve o arquivo `bedrock-server-X.XX.XX.XX.zip`

### Transferir para Android:

**Opção A: USB**
1. Conecte o Android no PC via USB
2. Copie o arquivo para `Download` ou `Documents`

**Opção B: Cloud (Drive, Dropbox)**
1. Faça upload no Google Drive
2. Baixe no Android usando o app

**Opção C: WhatsApp**
1. Envie o arquivo para você mesmo
2. Baixe no celular

### No Termux:

```bash
# 1. Dar permissão de acesso ao storage
termux-setup-storage

# 2. Criar diretório do servidor
cd ~/Minecraft-Server-Termux
mkdir -p bedrock-server
cd bedrock-server

# 3. Copiar arquivo (ajuste o caminho)
cp ~/storage/downloads/bedrock-server*.zip ./bedrock-server.zip

# 4. Extrair
unzip bedrock-server.zip
rm bedrock-server.zip

# 5. Dar permissão
chmod +x bedrock_server

# 6. Voltar e iniciar
cd ..
./start.sh
```

---

## 🔍 Diagnóstico: Qual é o Problema?

Execute estes comandos para diagnosticar:

### Teste 1: Conectividade básica
```bash
ping -c 3 8.8.8.8
```
- ✅ Se funcionar: Você tem internet
- ❌ Se falhar: Problema de conexão (verifique WiFi/dados)

### Teste 2: Resolução DNS
```bash
ping -c 3 google.com
```
- ✅ Se funcionar: DNS está OK
- ❌ Se falhar: Problema de DNS (use `./fix-dns.sh`)

### Teste 3: Acesso ao servidor Microsoft
```bash
ping -c 3 minecraft.azureedge.net
```
- ✅ Se funcionar: Acesso OK ao servidor
- ❌ Se falhar: Problema específico com DNS ou bloqueio

### Teste 4: Download direto
```bash
wget --spider https://minecraft.azureedge.net/bin-linux/bedrock-server-1.21.44.01.zip
```
- ✅ Se mostrar "200 OK": Servidor acessível
- ❌ Se falhar: Use download manual ou troque de rede

---

## 📋 Checklist Completo

Tente na ordem:

- [ ] 1. Execute `./fix-dns.sh`
- [ ] 2. Execute `./install.sh`
- [ ] 3. Se falhar, execute `./download-server.sh`
- [ ] 4. Se falhar, execute `termux-change-repo` e tente novamente
- [ ] 5. Se falhar, desligue WiFi e use dados móveis
- [ ] 6. Se falhar, baixe no PC e transfira manualmente

---

## 🆘 Ainda com Problemas?

Se NADA funcionar:

1. **Capture os erros:**
```bash
./install.sh 2>&1 | tee install-error.log
cat install-error.log
```

2. **Verifique versão do Termux:**
```bash
pkg update
pkg upgrade
```

3. **Reinstale dependências:**
```bash
pkg install -y wget curl unzip
```

4. **Abra uma issue no GitHub** com:
   - Saída do comando `./install.sh`
   - Resultado dos testes de diagnóstico
   - Tipo de conexão (WiFi/dados móveis)
   - País/região

---

## 💡 Dicas Importantes

- ✅ **Sempre use WiFi estável** durante downloads grandes
- ✅ **Evite redes corporativas** (podem bloquear downloads)
- ✅ **Desative VPNs** durante a instalação
- ✅ **Mantenha o Termux atualizado:** `pkg upgrade`
- ✅ **Tenha pelo menos 500MB livres** no armazenamento

---

**🎮 Depois que o servidor baixar, é só alegria!** ✨

Execute `./start.sh` e divirta-se!
