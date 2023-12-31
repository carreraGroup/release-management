#!/usr/bin/env bash
set -e

THIS_ABSPATH="$(cd "$(dirname "$0")"; pwd)"
TYPE="$1"

if [ -n "$TEST_DOCKER" ]; then
  export LOCAL_PATH="$THIS_ABSPATH/$TYPE/local"
  export REMOTE_PATH="$THIS_ABSPATH/$TYPE/remote"
  export PREFIX="docker run --rm -it -v $LOCAL_PATH:/gitrepo -v $REMOTE_PATH:$REMOTE_PATH -e EMAIL=fake@ballistagroup.com -e GIT_AUTHOR_NAME=$USER -e GIT_COMMITTER_NAME=$USER ballistagroup"

  docker build --tag ballistagroup/release -f "$THIS_ABSPATH/../Dockerfile" "$THIS_ABSPATH/.."
fi

"$THIS_ABSPATH/setup.sh" "$TYPE"
"$THIS_ABSPATH/test-bare.sh" "$TYPE"
"$THIS_ABSPATH/teardown.sh" "$TYPE"
