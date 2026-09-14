# Name: TRUDI
# Website: https://github.com/nebulae/trudi
# Description: Autonomous DFIR agent and MCP server for the SIFT Workstation, producing traced investigations with linked findings and reports.
# Category:
# Author: nebulae
# License: MIT License (https://github.com/nebulae/trudi/blob/main/LICENSE)
# Notes: trudi-dashboard
#
# Pinned to a commit on main rather than the 1.0.0 tag: that tag is 19 commits behind
# and predates the fixes that make TRUDI work on SIFT at all -- venv creation failing on
# the SIFT base (missing ensurepip), the version-matched pythonX.Y-venv, and the asyncio
# event-loop failures on python 3.12, which is what 24.04 ships.
#
# Upstream's install.sh is deliberately NOT used. It is written for a user setting up
# their own workstation and does several things a distro image must not do:
#
#   - builds its venv at ~/.venv, a generic path shared with anything else
#   - overwrites ~/.claude/CLAUDE.md (backing up first) with its orchestrator
#   - runs `claude mcp add trudi-sift --scope user`, per-user config that does not belong
#     in an image build (the claude CLI itself is installed, see sift.packages.claude-code)
#   - copies its bundled case studies into ~/cases
#   - installs requirements-dev.txt and runs a 1100-test suite
#
# This state does the image-level part only: the venv, the source, the dependencies and
# the dashboard launcher. Per-user setup is left to the user, who still needs to register
# the MCP server against their own Claude Code install to get the agent integration:
#
#   claude mcp add trudi-sift /opt/trudi/bin/python3 /opt/trudi/trudi/server.py --scope user
#
# The dashboard needs no API key and serves any completed case:
#
#   trudi-dashboard                      # serves ~/cases on http://127.0.0.1:8765
#   trudi-dashboard --cases-root /cases  # SIFT's evidence root
#
# A full-quality run needs ANTHROPIC_API_KEY and sends evidence content to the provider.
#
# Docs: https://github.com/nebulae/trudi/blob/main/docs/try-it-out.md

{% set commit = '32210c716da0850af01b58a7de9deb0b59fc3f1a' %}

include:
  - sift.packages.python3-virtualenv
  - sift.packages.python3-dev
  - sift.packages.git
  - sift.packages.build-essential
  - sift.packages.libssl-dev
  # the agent side of TRUDI is driven through Claude Code
  - sift.packages.claude-code
  # TRUDI shells out to these; all but binwalk are already part of SIFT
  - sift.packages.binwalk
  - sift.packages.libewf-tools
  - sift.packages.pff-tools
  - sift.packages.pst-utils
  - sift.packages.sleuthkit
  - sift.packages.tcpxtract

sift-python3-package-trudi-virtualenv:
  virtualenv.managed:
    - name: /opt/trudi
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv
      - sls: sift.packages.python3-dev
      - sls: sift.packages.build-essential
      - sls: sift.packages.libssl-dev

sift-python3-package-trudi-git:
  git.latest:
    - name: https://github.com/nebulae/trudi.git
    - target: /opt/trudi/trudi
    - rev: {{ commit }}
    - force_clone: True
    - force_reset: True
    - require:
      - virtualenv: sift-python3-package-trudi-virtualenv
      - sls: sift.packages.git

# requirements.txt only -- requirements-dev.txt is the test-suite tooling and has no
# place on a built image.
sift-python3-package-trudi:
  pip.installed:
    - requirements: /opt/trudi/trudi/requirements.txt
    - bin_env: /opt/trudi/bin/python3
    - require:
      - git: sift-python3-package-trudi-git

# bin/trudi-dashboard defaults to $HOME/trudi and $HOME/.venv; point it at the paths this
# state actually used. Anything the user passes still reaches the launcher.
sift-python3-package-trudi-dashboard:
  file.managed:
    - name: /usr/local/bin/trudi-dashboard
    - mode: 755
    - force: True
    - makedirs: False
    - contents: |
        #!/bin/bash
        # SIFT wrapper for TRUDI's dashboard launcher.
        # Managed by sift.python3-packages.trudi -- local edits will be overwritten.
        export TRUDI_DIR="${TRUDI_DIR:-/opt/trudi/trudi}"
        export VENV_PY="${VENV_PY:-/opt/trudi/bin/python3}"
        exec "$TRUDI_DIR/bin/trudi-dashboard" "$@"
    - require:
      - pip: sift-python3-package-trudi
      - sls: sift.packages.claude-code
