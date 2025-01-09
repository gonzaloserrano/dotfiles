#!/usr/bin/env bash

# xcode cli tools
xcode-select --install

# brew packages
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

declare -a brew_tools=(
    'age'
    'asdf'
    'ast-grep'
    'bash-language-server'
    'bat'
    'cmake'
    'colordiff'
    'coreutils'
    'difftastic'
    'dive'
    'docker-credential-helper-ecr'
    'docker-mac-net-connect'
    'exa'
    'fzf'
    'gh'
    'ghostty'
    'git'
    'git-delta'
    'gnu-sed'
    'gnu-tar'
    'go'
    'google-cloud-sdk'
    'graphviz'
    'helm'
    'htop'
    'httpie'
    'hugo'
    'imagemagick'
    'jless'
    'jq'
    'jump'
    'k9s'
    'kind'
    'kubectx'
    'kubernetes-cli'
    'kustomize'
    'lua-language-server'
    'mas'
    'ncdu'
    'node'
    'nvim'
    'ollama'
    'orbstack'
    'parallel'
    'pdfgrep'
    'pidcat'
    'pipx'
    'python'
    'rename'
    'ripgrep'
    'shellcheck'
    'silicon'
    'skopeo'
    'sql-language-server'
    'tig'
    'tree'
    'watch'
    'yaml-language-server'
    'zsh'
    'zsh-autosuggestions'
    'zsh-history-substring-search'
    'zsh-syntax-highlighting'

	# casks
    'bitbar'
    'cleanshot'
    'chatgpt'
    'docker'
    'dropbox'
    'google-chrome'
    'jumpcut'
    'keybase'
    'notion'
    'skype'
    'slack'
    'spotify'
    'tableplus'
    'the-unarchiver'
    'visual-studio-code'
    'vlc'
    'webtorrent'
    'zoom'
)

for tool in "${brew_tools[@]}"; do
  brew install "$tool"
done

declare -a go_tools=(
  'github.com/99designs/gqlgen'
  'github.com/golangci/golangci-lint/cmd/golangci-lint'
  'github.com/kyoh86/richgo'
  'github.com/matryer/moq'
  'github.com/mfuentesg/ksd'
  'mvdan.cc/gofumpt'
  'github.com/go-delve/delve/cmd/dlv'
  'github.com/aarzilli/gdlv'
  'github.com/Yash-Handa/logo-ls'
  'github.com/msoap/go-carpet'
)

for tool in "${go_tools[@]}"; do
  go install "$tool@latest"
done

# Install Oh My ZSH
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mkdir -p ~/.helm/plugins
helm plugin install https://github.com/databus23/helm-diff --version master

# k8s and istio stuff

asdf plugin-add istioctl https://github.com/virtualstaticvoid/asdf-istioctl.git
asdf plugin-add tctl https://github.com/chirauki/asdf-tctl.git
asdf current

kubectl krew index add kvaps https://github.com/kvaps/krew-index

declare -a krew_tools=(
    'neat'
    'pod-dive'
    'view-secret'
    'evict-pod'
    'kvaps/node-shell'
)

for tool in "${krew_tools[@]}"; do
  kubectl krew install "$tool"
done
