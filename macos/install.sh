#!/usr/bin/env bash

set -x -e

# xcode cli tools
# only once
# xcode-select --install

# brew packages

# do this once:
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# echo >> /Users/gonzalo/.zprofile
# echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/gonzalo/.zprofile
# eval "$(/opt/homebrew/bin/brew shellenv)"

declare -a brew_tools=(
    # these first
    'coreutils'
    'cmake'
    'go'
    'zsh'

    # rest
    '1password'
    'age'
    'asdf'
    'ast-grep'
    'awscli'
    'bash-language-server'
    'bat'
    'bitwarden'
    'chipmk/tap/docker-mac-net-connect'
    'colordiff'
    'crane'
    'difftastic'
    'dive'
    'docker-credential-helper-ecr'
    'eza'
    'fzf'
    'gemini'
    'gh'
    'ghostty'
    'git'
    'git-delta'
    'gnu-sed'
    'gnu-tar'
    'google-cloud-sdk'
    'graphviz'
    'gum'
    'helm'
    'hiddenbar'
    'htop'
    'httpie'
    'hugo'
    'imagemagick'
    'jless'
    'jq'
    'jump'
    'k9s'
    'kind'
    'kube-ps1'
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
    'terraform'
    'tig'
    'tree'
    'watch'
    'yaml-language-server'
    'yq'
    'zsh-autosuggestions'
    'zsh-history-substring-search'
    'zsh-syntax-highlighting'

    # casks
    'chatgpt'
    'cleanshot'
    'docker'
    'dropbox'
    'font-hasklug-nerd-font'
    'google-chrome'
    'jumpcut'
    'keybase'
    'keyboardcleantool'
    'monitorcontrol'
    'notion'
    'slack'
    'spotify'
    'tableplus'
    'the-unarchiver'
    'visual-studio-code'
    'vlc'
    'xbar'
    'zoom'
)

for tool in "${brew_tools[@]}"; do
  brew install "$tool"
done

declare -a go_tools=(
  'github.com/99designs/gqlgen'
  'github.com/Yash-Handa/logo-ls'
  'github.com/aarzilli/gdlv'
  'github.com/daveadams/go-rapture/cmd/rapture'
  'github.com/go-delve/delve/cmd/dlv'
  'github.com/golangci/golangci-lint/cmd/golangci-lint'
  'github.com/google/go-containerregistry/cmd/crane'
  'github.com/kyoh86/richgo'
  'github.com/matryer/moq'
  'github.com/mfuentesg/ksd'
  'github.com/msoap/go-carpet'
  'mvdan.cc/gofumpt'
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

declare -a js_tools=(
	'happy-coder'
	'openai/codex'
	'simple-photo-gallery'
	'vtsls/language-server'
)
for tool in "${js_tools[@]}"; do
  npm install -g "$tool"
done

# symlinks
mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty
ln -sf ~/Documents/shell/dotfiles/ghostty.config ~/Library/Application\ Support/com.mitchellh.ghostty/config
