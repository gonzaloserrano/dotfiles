#!/usr/bin/env bash

# xcode cli tools
xcode-select --install

# for logo-ls
brew tap homebrew/cask-fonts
brew install --cask font-hasklug-nerd-font

brew tap tetratelabs/getenvoy

declare -a brew_tools=(
    'weaveworks/tap/eksctl'
    'kubernetes-cli'
    'kustomize'
    'kubectx'
    'helm'
    #'https://raw.githubusercontent.com/Homebrew/homebrew-core/c3a105c41a8f8be942bf97554466af236c2fac72/Formula/kubernetes-helm.rb'
    'bumpversion'
    'getenvoy'
    'dive'
    'Ladicle/kubectl-bindrole/kubectl-rolesum'
    'dty1er/tap/kubecolor'
    'google-cloud-sdk'
    'k9s'
    'skopeo'
    'kind'
    'jless'
    'yaml-language-server'
    'bash-language-server'
    'lua-language-server'
    'sql-language-server'
    'ast-grep'
    'asdf'
)

mkdir -p ~/.helm/plugins
# helm plugin install https://github.com/viglesiasce/helm-gcs.git --version v0.2.0
# helm repo add paack-repo gs://paack-system-production-charts
# helm repo update
helm plugin install https://github.com/databus23/helm-diff --version master

for tool in "${brew_tools[@]}"; do
  brew install "$tool"
done

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

declare -a go_tools=(
  'github.com/99designs/gqlgen'
  'github.com/a-h/generate/cmd/schema-generate'
  'github.com/golangci/golangci-lint/cmd/golangci-lint'
  'github.com/kyoh86/richgo'
  'github.com/matryer/moq'
  'github.com/mfuentesg/ksd'
  'mvdan.cc/gofumpt'
  'github.com/go-delve/delve/cmd/dlv'
  'github.com/aarzilli/gdlv'
  'github.com/cortesi/modd/cmd/modd'
  'github.com/Yash-Handa/logo-ls'
  'github.com/oligot/go-mod-upgrade'
  'github.com/tetratelabs/car'
  'github.com/tetratelabs/getmesh'
  'github.com/msoap/go-carpet'
)

for tool in "${go_tools[@]}"; do
  go install "$tool@latest"
done

asdf plugin-add istioctl https://github.com/virtualstaticvoid/asdf-istioctl.git
asdf install istioctl latest

asdf plugin-add tctl https://github.com/chirauki/asdf-tctl.git
asdf install tctl 1.7.0

asdf current
# asdf list all istioctl
# asdf global istioctl latest
# asdf shell istioctl latest
