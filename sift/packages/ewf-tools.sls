include:
  - sift.packages.libewf
  - sift.packages.libewf-dev

sift-package-ewf-tools:
  pkg.installed:
    - name: ewf-tools
    - require:
      - sls: sift.packages.libewf
      - sls: sift.packages.libewf-dev
