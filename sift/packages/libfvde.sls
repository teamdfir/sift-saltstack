include:
  - sift.repos.gift

sift-package-libfvde:
  pkg.installed:
    - name: libfvde
    - require:
      - pkgrepo: gift-repo
