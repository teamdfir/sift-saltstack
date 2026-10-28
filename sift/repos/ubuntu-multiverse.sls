include:
  - sift.repos.ubuntu-sources

sift-multiverse-repo:
  file.replace:
    - name: /etc/apt/sources.list.d/ubuntu.sources
    - pattern: '^(Components: )(?!.*\bmultiverse\b)(.*)$'
    - repl: '\1\2 multiverse'
    - flags:
        - MULTILINE
    - backup: False
    - require:
      - file: sift-ubuntu-sources
    - onchanges_in:
      - module: sift-ubuntu-repo-refresh

