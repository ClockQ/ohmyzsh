autoload -U add-zsh-hook

# 用于从当前目录向上查找最近的 .nvmrc，避免依赖 nvm 内部函数在 oh-my-zsh lazy load 下不可用。
_nvm_auto_use_find_nvmrc() {
  local dir="$PWD"

  while [ "$dir" != "/" ]; do
    if [ -f "$dir/.nvmrc" ]; then
      printf '%s\n' "$dir/.nvmrc"
      return 0
    fi

    dir="${dir:h}"
  done

  return 1
}

# 用于目录切换后根据 .nvmrc 自动切换 Node 版本；未安装时只提示，避免自动下载或改变当前环境。
load-nvmrc() {
  if ! type nvm >/dev/null 2>&1; then
    printf '\033[31m%s\033[0m\n' "[nvm-auto-use] Warning: nvm is not loaded. Check oh-my-zsh nvm plugin order."
    return 0
  fi

  local nvmrc_path
  nvmrc_path="$(_nvm_auto_use_find_nvmrc)"

  local current_version
  local default_version

  current_version="$(nvm version)"
  default_version="$(nvm version default)"

  if [ -n "$nvmrc_path" ]; then
    local requested_version
    local nvmrc_node_version

    requested_version="$(command tr -d '[:space:]' < "$nvmrc_path")"

    if [ -z "$requested_version" ]; then
      printf '\033[31m%s\033[0m\n' "[nvm-auto-use] Warning: $nvmrc_path is empty."
      return 0
    fi

    nvmrc_node_version="$(nvm version "$requested_version")"

    if [ "$nvmrc_node_version" = "N/A" ]; then
      printf '\033[31m%s\033[0m\n' "[nvm-auto-use] Warning: Node version '$requested_version' from $nvmrc_path is not installed. Run 'nvm install' manually if needed."
      return 0
    fi

    if [ "$nvmrc_node_version" != "$current_version" ]; then
      nvm use "$requested_version"
    fi

    return 0
  fi

  if [ "$current_version" != "$default_version" ]; then
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
