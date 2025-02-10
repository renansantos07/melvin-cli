
# Melvin CLI

**Melvin CLI** é uma ferramenta de linha de comando para gerenciar operações de fluxo Git em repositórios, como criação e finalização de branches de `feature`, `release`, e `hotfix`, bem como a criação de Pull Requests automáticos.

## 🚀 Como instalar e usar

### 1. Instalar o GitHub CLI no Windows

Antes de usar o Melvin CLI, é necessário instalar o GitHub CLI, que permite criar Pull Requests diretamente do terminal.

- Acesse o [site oficial do GitHub CLI](https://cli.github.com/) e baixe o instalador para Windows.
- Após o download, execute o instalador e siga as instruções para concluir a instalação.
- Após a instalação, abra um terminal e verifique se o GitHub CLI foi instalado corretamente executando o comando:
  ```bash
  gh --version
  ```

### 2. Instalar o Melvin CLI

- Realize o clone do repositório Melvin CLI:
  ```bash
  git clone https://github.com/usuario/melvin-cli.git
  ```
- Navegue até o diretório do repositório:
  ```bash
  cd melvin-cli
  ```
- Execute o arquivo `install.bat` para configurar o Melvin CLI no seu sistema:
  ```bash
  install.bat
  ```

### 3. Usar o Melvin CLI

Após a instalação, abra um novo terminal e execute o comando abaixo para ver os comandos disponíveis:
```bash
melvin --help
```

---

### Comandos Disponíveis

#### 1. `init-flow`
- **Descrição:** Inicializa o fluxo Git, configurando as branches `main` e `develop` se ainda não estiverem presentes.
- **Como usar:** 
  ```bash
  melvin init-flow
  ```

#### 2. `feature start [nome]`
- **Descrição:** Cria uma nova branch de feature a partir de `main`.
- **Como usar:** 
  ```bash
  melvin feature start nome_da_feature
  ```

#### 3. `feature finish [--no-pr] [nome]`
- **Descrição:** Finaliza a branch de feature, mergeando-a para `develop` e criando um Pull Request (PR). 
  - Caso use a flag `--no-pr`, o merge será feito diretamente sem criar um PR.
- **Como usar:** 
  ```bash
  melvin feature finish nome_da_feature
  # ou
  melvin feature finish --no-pr nome_da_feature
  ```

#### 4. `release start [nome]`
- **Descrição:** Cria uma nova branch de release a partir de `main`.
- **Como usar:** 
  ```bash
  melvin release start nome_da_release
  ```

#### 5. `release finish [--no-pr] [nome]`
- **Descrição:** Finaliza a branch de release, mergeando-a para `develop` e criando um Pull Request (PR) para `main`. 
  - Caso use a flag `--no-pr`, o merge será feito diretamente sem criar um PR.
- **Como usar:** 
  ```bash
  melvin release finish nome_da_release
  # ou
  melvin release finish --no-pr nome_da_release
  ```

#### 6. `hotfix start [nome]`
- **Descrição:** Cria uma nova branch de hotfix a partir de `main`.
- **Como usar:** 
  ```bash
  melvin hotfix start nome_do_hotfix
  ```

#### 7. `hotfix finish [--no-pr] [nome]`
- **Descrição:** Finaliza a branch de hotfix, mergeando-a para `develop` e criando um Pull Request (PR) para `main`.
  - Caso use a flag `--no-pr`, o merge será feito diretamente sem criar um PR.
- **Como usar:** 
  ```bash
  melvin hotfix finish nome_do_hotfix
  # ou
  melvin hotfix finish --no-pr nome_do_hotfix
  ```

#### 8. `pr [base] [head] [title] [body]`
- **Descrição:** Cria um Pull Request manualmente para o GitHub.
- **Como usar:** 
  ```bash
  melvin pr base_da_branch head_da_branch titulo_do_pr corpo_do_pr
  ```

#### 9. `merge-features [release] [features...]`
- **Descrição:** Faz merge de várias branches de feature ordenadas pela data do último push para uma branch de release.
- **Como usar:** 
  ```bash
  melvin merge-features release_v1.0 feature_1 feature_2 feature_3
  ```

#### 10. `--help`
- **Descrição:** Exibe as opções de ajuda e informações sobre o uso de cada comando.
- **Como usar:** 
  ```bash
  melvin --help
  ```

### Exemplo de Uso

1. **Iniciar o fluxo Git:**
   ```bash
   melvin init-flow
   ```

2. **Criar uma nova feature:**
   ```bash
   melvin feature start nova_feature
   ```

3. **Finalizar uma feature e criar um Pull Request para `develop`:**
   ```bash
   melvin feature finish nova_feature
   ```

4. **Finalizar uma release e criar um Pull Request para `main`:**
   ```bash
   melvin release finish v1.0
   ```

5. **Criar um Pull Request manualmente:**
   ```bash
   melvin pr develop feature/nova_feature "Novo PR de Feature" "Descrição detalhada do PR"
   ```

### Contribuições

Se você encontrar algum problema ou tiver sugestões para melhorias, sinta-se à vontade para abrir uma issue ou enviar um pull request.
