#!/usr/bin/env bash

set -x

# xcode cli tools
# only once
# 1. install Xcode from App Store
# 2. sudo xcodebuild -license
# 3. xcode-select --install

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
    # 'zsh' -- latest macOS has 5.9

    # rest
    # '1password' -- will use browser
    # 'age' -- experimental
    'ast-grep'
    'awscli'
    'bash-language-server'
    'bat'
    'bitwarden'
    'chipmk/tap/docker-mac-net-connect'
    'colordiff'
    'difftastic'
    'docker-credential-helper-ecr'
    'eza'
    'fzf'
    'gemini'
    'gh'
    'git'
    'git-delta'
    'gnu-sed'
    'gnu-tar'
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
    'ncdu'
    'node'
    'nvim'
    'ollama'
    'parallel'
    'pdfgrep'
    'pidcat'
    'pipx'
    'python'
    'rename'
    'ripgrep'
    'shellcheck'
    'silicon'
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

	# -- no need for $JOB
    # 'crane'
    # 'dive'
    # 'google-cloud-sdk'
    # 'graphviz'
    # 'orbstack'
    # 'skopeo'
	# -- END OF: no need for $JOB

    # casks
    'chatgpt'
    'cleanshot'
    'docker'
    'dropbox'
    'font-hasklug-nerd-font'
    'ghostty'
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
  #'github.com/Yash-Handa/logo-ls'
  'github.com/aarzilli/gdlv'
  # 'github.com/daveadams/go-rapture/cmd/rapture' -- no need for $JOB
  'github.com/go-delve/delve/cmd/dlv'
  # 'github.com/golangci/golangci-lint/cmd/golangci-lint' -- probably can go run pinned version instead
  # 'github.com/google/go-containerregistry/cmd/crane' --no need for $JOB
  'github.com/kyoh86/richgo'
  'github.com/matryer/moq'
  # 'github.com/mfuentesg/ksd' --no need for $JOB
  'github.com/msoap/go-carpet'
  # 'mvdan.cc/gofumpt' -- probably can go run pinned version instead
  'github.com/grishy/gopkgview'
)

for tool in "${go_tools[@]}"; do
  go install "$tool@latest"
done

# Install Oh My ZSH
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

declare -a js_tools=(
	'openai/codex'
	'simple-photo-gallery'
	'vtsls/language-server'
)
for tool in "${js_tools[@]}"; do
  npm install -g "$tool"
done

# Claude Code
if ! command -v claude &> /dev/null; then
  curl -fsSL https://claude.ai/install.sh | bash
  claude update
fi
