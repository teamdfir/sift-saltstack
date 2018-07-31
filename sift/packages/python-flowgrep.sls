include:
  - sift.repos.sift

sift-pacakge-python-flowgrep:
  pkg.installed:
    - name: python-flowgrep
    - require:
      - sls: sift.repos.sift
