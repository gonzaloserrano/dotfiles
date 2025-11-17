#! /bin/bash

set -e

REPO_URL=$1
USERNAME=$(echo $REPO_URL | awk -F':' '{print $2}' | awk -F'/' '{print $1}')
REPONAME=$(echo $REPO_URL | awk -F':' '{print $2}' | awk -F'/' '{print $2}' | sed 's/\.git//')
echo "Username: $USERNAME"
echo "Repo name: $REPONAME"

LOCAL_DIR=/Users/gonzalo/go/src/github.com/$USERNAME
mkdir -p $LOCAL_DIR
LOCAL_REPO="$LOCAL_DIR/$REPONAME"
if [ -d "$LOCAL_REPO" ]; then
  echo "Repository already exists at: $LOCAL_REPO"
else
  cd $LOCAL_DIR
  git clone $REPO_URL
fi
