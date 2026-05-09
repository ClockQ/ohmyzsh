#!/bin/bash

# 追加环境变量
function append_path() {
    local new_path="$1"
    if [[ ":$PATH:" != *":$new_path:"* ]]; then
        export PATH="$PATH:$new_path"
    fi
}


# brew 配置
export BREW_HOME=/opt/homebrew
append_path ${BREW_HOME}/bin


# nvim 配置
export NVIM_HOME=/opt/nvim
append_path ${NVIM_HOME}/bin


# golang 配置
export GOPATH=~/.config/go
append_path ${GOPATH}/bin


# Java 配置
export JAVA_HOME=/opt/jdk
append_path ${JAVA_HOME}/bin

## maven 配置
export MVN_HOME=/opt/maven
append_path ${MVN_HOME}/bin


# Tools 工具配置
# ChromeDriver 配置
export CHROME_HOME=/opt/chrome
append_path ${CHROME_HOME}

# gnu tar 配置
append_path "/opt/homebrew/opt/gnu-tar/libexec/gnubin"


# nvm 配置
export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh
## 自定义 npm 缓存路径（推荐！改到你想放的位置）
export NPM_CONFIG_CACHE="$HOME/.npm/cache"
## 国内镜像加速（解决下载慢）
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node

# pnpm 配置
export PNPM_HOME="/opt/pnpm"
append_path ${PNPM_HOME}


# AI 配置
## lingyaai token
export OPENAI_API_KEY="sk-kneGQxmeRBBHs1c3nFCISclG2KKNHORuphnM9T2rYzhH3QmR"


# openclaw 配置
## OpenClaw Completion
source "/Users/clock/.openclaw/completions/openclaw.zsh"
## bun 配置
append_path "/Users/clock/.bun/bin"

# OpenFang
export PATH=/Users/clock/.openfang/bin:$PATH

