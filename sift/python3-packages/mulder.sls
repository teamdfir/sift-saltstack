{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - sift.config.user.user
  - sift.packages.git
  - sift.packages.sleuthkit
  - sift.packages.yara
  - sift.packages.p7zip-full
  - sift.packages.binutils
  - sift.packages.pipx
  - sift.packages.dotnet

sift-python3-package-mulder:
  cmd.run:
    - name: pipx install "mulder-dfir[forensics]" --force
    - runas: {{ user }}
    - require:
      - sls: sift.packages.pipx
      - sls: sift.packages.git
      - sls: sift.packages.sleuthkit
      - sls: sift.packages.yara
      - sls: sift.packages.p7zip-full
      - sls: sift.packages.binutils
      - sls: sift.packages.dotnet
      - user: sift-user-{{ user }}

sift-python3-package-mulder-setup:
  cmd.run:
    - name: mulder setup --yes
    - runas: {{ user }}
    - cwd: /home/{{ user }}/.local/bin
    - require:
      - cmd: sift-python3-package-mulder

sift-python3-package-mulder-ensurepath:
  cmd.run:
    - name: pipx ensurepath
    - runas: {{ user }}
    - cwd: /home/{{ user }}/.local/bin
    - require:
      - cmd: sift-python3-package-mulder-setup

