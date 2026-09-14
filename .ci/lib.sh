#!/bin/bash
#
# Shared plumbing for the .ci dev scripts. Not meant to be run directly.

OS=${OS:-22.04}
SALT=${SALT:-3007}
DOCKER=${DOCKER:-docker}
IMAGE=${IMAGE:-ghcr.io/ekristen/cast-tools/saltstack-tester:${OS}-${SALT}}

require_repo_root() {
  if [ ! -d sift ]; then
    echo "Error: run this from the repository root (no ./sift directory here)." >&2
    exit 1
  fi
}

# Bind-mounting $PWD only works when the daemon shares this filesystem. Against a
# remote context (ssh:// or tcp://) the mount silently resolves on the remote host
# and salt-call finds an empty state tree, so stream the tree in instead.
daemon_is_local() {
  local host
  host=$("$DOCKER" context inspect --format '{{.Endpoints.docker.Host}}' 2>/dev/null) || return 0
  case "$host" in
    ssh://*|tcp://*) return 1 ;;
    *) return 0 ;;
  esac
}

# run_in_tester <extra docker args...> -- <shell command to run inside>
#
# Puts the repo at /srv/salt and runs the command with that as the cwd.
run_in_tester() {
  local docker_args=()
  while [ $# -gt 0 ] && [ "$1" != "--" ]; do
    docker_args+=("$1"); shift
  done
  shift # past the --
  local inner=$1

  # bash 3.2 (still what macOS ships) errors on empty-array expansion under set -u,
  # hence the ${a[@]+"${a[@]}"} guard rather than a bare "${a[@]}".
  if daemon_is_local; then
    exec "$DOCKER" run --rm -i -v "$PWD:/srv/salt" -w /srv/salt \
      --cap-add SYS_ADMIN ${docker_args[@]+"${docker_args[@]}"} "$IMAGE" \
      bash -c "$inner"
  fi

  # Remote daemon: pipe the tree in over stdin. pipefail so a salt-call failure
  # surfaced by --retcode-passthrough still becomes our exit status.
  echo "==> remote docker context: streaming the state tree into the container" >&2
  set -o pipefail
  tar czf - --exclude=.git . | "$DOCKER" run --rm -i \
    --cap-add SYS_ADMIN ${docker_args[@]+"${docker_args[@]}"} "$IMAGE" \
    bash -c "mkdir -p /srv/salt && tar xzf - -C /srv/salt && cd /srv/salt && $inner"
}
