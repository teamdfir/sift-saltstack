include:
  - sift.repos.sift

liblightgrep:
  pkg.installed:
    - name: liblightgrep
    - require:
      - sls: sift.repos.sift
