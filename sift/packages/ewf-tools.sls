include:
  - sift.packages.libewf2
  - sift.packages.libewf-dev

sift-package-ewf-tools:
  pkg.installed:
    - name: ewf-tools
    - require:
      - sls: sift.packages.libewf2
      - sls: sift.packages.libewf-dev
