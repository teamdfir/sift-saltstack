#!/bin/bash
#
# Apply a single Salt state in the same tester image CI uses.
#
#   .ci/test-state.sh sift.packages.aeskeyfind
#   OS=24.04 SALT=3006 .ci/test-state.sh sift.scripts.zimmerman
#
# Env: OS (22.04|24.04), SALT (3006|3007), DOCKER (docker|nerdctl|podman).
# Works against a remote docker context; see .ci/lib.sh.
#
# Must be run from the repository root.

set -euo pipefail

# shellcheck source=.ci/lib.sh
. "$(dirname "$0")/lib.sh"

if [ $# -lt 1 ]; then
  echo "Usage: $0 <state>" >&2
  echo "Example: $0 sift.packages.aeskeyfind" >&2
  exit 1
fi

STATE=$1
require_repo_root

run_in_tester -- "
  export DEBIAN_FRONTEND=noninteractive
  salt-call --local -l info --file-root . --retcode-passthrough \
    --state-output=mixed state.sls '$STATE' pillar='{sift_user: root}'
"
