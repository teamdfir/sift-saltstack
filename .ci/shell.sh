#!/bin/bash
#
# Drop into an interactive shell in the tester image with the state tree at
# /srv/salt, for poking at a state by hand.
#
#   .ci/shell.sh
#   OS=24.04 SALT=3006 .ci/shell.sh
#
# Inside the container:
#
#   salt-call --local -l debug --file-root . --state-output=mixed \
#     state.sls sift.packages.aeskeyfind pillar='{sift_user: root}'
#
# Env: OS (22.04|24.04), SALT (3006|3007), DOCKER (docker|nerdctl|podman).
#
# Port 8080 maps to container port 80 so states that stand up apache (cyberchef)
# can be checked in a browser -- on a remote context that binds on the remote host.
# On a remote context the tree is a copy, so host edits do not appear live.
#
# Must be run from the repository root.

set -euo pipefail

# shellcheck source=.ci/lib.sh
. "$(dirname "$0")/lib.sh"

require_repo_root

run_in_tester -t -p 8080:80 -- "exec /bin/bash"
