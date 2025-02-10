# Inicializa o Git Flow se não estiver configurado
init_git_flow() {
  if [ ! -d ".git" ]; then
    echo "Repositório Git não encontrado. Inicializando..."
    git init
  fi

  if ! git branch | grep -q "develop"; then
    echo "Criando branch develop..."
    git checkout -b develop
    git push -u origin develop
  fi

  if ! git branch | grep -q "main"; then
    echo "Criando branch main..."
    git checkout -b main
    git push -u origin main
  fi

  echo "Git Flow inicializado com sucesso!"
}

# Função para criar uma nova feature branch a partir de main
create_feature() {
  git checkout main
  git pull origin main
  git checkout -b feature/$1
  echo "Feature branch 'feature/$1' criada com sucesso!"
}

# Função para iniciar um release a partir de main
create_release() {
  git checkout main
  git pull origin main
  git checkout -b release/$1
  echo "Release branch 'release/$1' criada com sucesso!"
}

# Função para corrigir um hotfix a partir de main
create_hotfix() {
  git checkout main
  git pull origin main
  git checkout -b hotfix/$1
  echo "Hotfix branch 'hotfix/$1' criada com sucesso!"
}

# Função para criar um Pull Request via GitHub CLI
create_pull_request() {
  git push origin $1
  gh pr create --base $2 --head $1 --title "Merge $1 into $2" --body "Este é um Pull Request automático para a branch $1."
  echo "Pull Request de '$1' para '$2' criado com sucesso!"
}

# Função para finalizar uma feature criando um PR para develop
finish_feature() {
  echo "Publicando feature '$1'..."
  git push origin "feature/$1"
  echo "Criando Pull Request para a feature '$1'..."
  create_pull_request "feature/$1" "develop"
}

# Função para finalizar um release criando um PR para main
finish_release() {
  echo "Publicando release '$1'..."
  git push origin "release/$1"
  echo "Criando Pull Request para o release '$1'..."
  create_pull_request "release/$1" "main"
}

finish_release() {
  git checkout develop
  git pull origin develop
  git merge release/$1
  git push origin develop
  git push origin "release/$1"
  echo "Criando Pull Request para o release '$1'..."
  create_pull_request "release/$1" "main"
  echo "Release '$1' finalizado e mergeado na develop com Pull Request para main!"
}

# Função para finalizar um hotfix criando um PR para main
finish_hotfix() {
  git checkout develop
  git pull origin develop
  git merge hotfix/$1
  git push origin develop
  echo "Publicando hotfix '$1'..."
  git push origin "hotfix/$1"
  echo "Criando Pull Request para o hotfix '$1'..."
  create_pull_request "hotfix/$1" "main"
  echo "hotfix '$1' finalizado e mergeado na develop com Pull Request para main!"
}

# Função para fazer merge de múltiplas features ordenadas por data do último push
merge_features() {
  release_branch=$1
  shift
  feature_branches=("$@")

  echo "📌 Obtendo datas de push das branches..."
  declare -A branch_push_dates

  for branch in "${feature_branches[@]}"; do
    last_push_date=$(git log origin/$branch -1 --format="%ci" 2>/dev/null)
    if [ -z "$last_push_date" ]; then
      echo "⚠️  Branch $branch não encontrada no repositório remoto. Pulando..."
      continue
    fi
    branch_push_dates["$branch"]="$last_push_date"
  done

  echo "🔄 Ordenando branches por data do último push..."
  sorted_branches=($(for branch in "${!branch_push_dates[@]}"; do
    echo "$branch ${branch_push_dates[$branch]}"
  done | sort -k2 | awk '{print $1}'))

  echo "🚀 Fazendo checkout para a release: $release_branch"
  git checkout $release_branch
  git pull origin $release_branch

  for branch in "${sorted_branches[@]}"; do
    echo "🔄 Mergeando $branch..."
    git merge origin/$branch --no-ff -m "Merge $branch into $release_branch"
    if [ $? -ne 0 ]; then
      echo "❌ Conflito detectado ao mergear $branch. Resolva manualmente e continue."
      exit 1
    fi
  done

  echo "✅ Merge de todas as features concluído com sucesso!"
}

# Função para mostrar o uso
show_help() {
  echo "Uso: melvin [comando] [opções]"
  echo "Comandos disponíveis:"
  echo "  init-flow                - Inicializa o Git Flow"
  echo "  feature start [nome]        - Cria uma nova feature"
  echo "  feature finish [nome]        - Finaliza uma feature e cria um PR para develop"
  echo "  release start [nome]        - Cria uma nova release"
  echo "  release finish [nome]        - Finaliza uma release e cria um PR para master"
  echo "  hotfix start [nome]         - Cria um novo hotfix"
  echo "  hotfix finish [nome]         - Finaliza um hotfix e cria um PR para master"
  echo "  pr [base] [head] [title] [body] - Cria um PR manualmente"
  echo "  merge-features [release] [features...] - Faz merge das features na release ordenadas pelo push mais antigo"
  echo "  --help                   - Exibe esta ajuda"
}

# Verifica o comando fornecido
case "$1" in
  init-flow) init_git_flow ;;
  feature) 
    case "$2" in 
      start) create_feature "$3" ;;
      finish) finish_feature "$3" ;;
      *) echo "Opção inválida para feature. Use -c para criar ou -f para finalizar." ;;
    esac
    ;;
  release) 
    case "$2" in 
      start) create_release "$3" ;;
      finish) finish_release "$3" ;;
      *) echo "Opção inválida para release. Use -c para criar ou -f para finalizar." ;;
    esac
    ;;
  hotfix) 
    case "$2" in 
      start) create_hotfix "$3" ;;
      finish) finish_hotfix "$3" ;;
      *) echo "Opção inválida para hotfix. Use -c para criar ou -f para finalizar." ;;
    esac
    ;;
  pr) create_pull_request "$2" "$3" "$4" "$5" ;;
  merge-features) 
    if [ $# -lt 3 ]; then
      echo "❌ Uso incorreto! Exemplo: melvin merge-features release-v1.2 feature-1 feature-2 feature-3"
      exit 1
    fi
    merge_features "$2" "${@:3}"
    ;;
  --help) show_help ;;
  *) echo "Comando inválido! Use --help para ver os comandos disponíveis." ;;
esac
