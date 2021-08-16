include:
  - sift.packages.gnome-shell-extensions

sift-package-gnome-shell-extensions-dashtodock:
  pkg.installed:
    - name: gnome-shell-extensions-dashtodock
    - require:
      - sls: sift.packages.gnome-shell-extensions