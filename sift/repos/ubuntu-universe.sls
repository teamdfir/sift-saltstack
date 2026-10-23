include:
  - sift.repos.ubuntu-sources

sift-universe-repo:
  file.replace:
    - name: /etc/apt/sources.list.d/ubuntu.sources
    - pattern: '^(Components: )(?!.*\buniverse\b)(.*)$'
    - repl: '\1\2 universe'
    - flags:
        - MULTILINE
    - backup: False
    - require:
      - file: sift-ubuntu-sources
    - onchanges_in:
      - module: sift-ubuntu-repo-refresh
