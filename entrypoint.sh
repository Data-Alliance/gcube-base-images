#!/usr/bin/env bash
set -e

if [ -n "$GIT_USER_NAME" ]; then
  git config --global user.name "$GIT_USER_NAME"
fi
if [ -n "$GIT_USER_EMAIL" ]; then
  git config --global user.email "$GIT_USER_EMAIL"
fi

if [ -n "$GIT_TOKEN" ]; then
  HOST="${GIT_HOST:-github.com}"
  git config --global credential.helper store
  echo "https://git:${GIT_TOKEN}@${HOST}" > ~/.git-credentials
  chmod 600 ~/.git-credentials
fi

if [ -n "$GIT_CLONE_REPO" ]; then
  DEST="/workspace/$(basename "$GIT_CLONE_REPO" .git)"
  if [ ! -d "$DEST" ]; then
    # Some nodes open outbound network a few seconds after the container starts,
    # so retry for up to ~1 minute instead of giving up on the first failure.
    for i in $(seq 1 12); do
      git clone "$GIT_CLONE_REPO" "$DEST" && break
      echo "[entrypoint] clone 재시도 ($i/12) — 5초 후 다시 시도"
      sleep 5
    done
    [ -d "$DEST" ] || echo "[entrypoint] WARN: clone 실패 — 건너뜀"
  fi
fi

exec "$@"