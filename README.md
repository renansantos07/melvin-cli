
# Melvin CLI

**Melvin CLI** é uma ferramenta de linha de comando para gerenciar operações de fluxo Git em repositórios, como criação e finalização de branches de `feature`, `release`, e `hotfix`, bem como a criação de Pull Requests automáticos.

## 🚀 Como instalar e usar

### Passos de Instalação

1. **Instalar no Windows**
   - Clone o repositório:
     ```bash
     git clone https://github.com/oi-melvin/melvin-cli.git
     ```
   - Navegue até a pasta do repositório:
     ```bash
     cd melvin-cli
     ```
   - Execute o arquivo `install.bat`:
     - Isso irá instalar as dependências necessárias e configurar o ambiente para rodar o `melvin-cli`.

2. **Usar o melvin-cli**
   - Abra um novo terminal.
   - Execute o comando:
     ```bash
     melvin --help
     ```

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
