sift-wine-i386-arch:
  cmd.run:
    - name: dpkg --add-architecture i386
    - unless: dpkg --print-foreign-architectures | grep i386

sift-wine-apt-update:
  pkg.uptodate:
    - refresh: True
    - require:
      - cmd: sift-wine-i386-arch

sift-wine:
  pkg.installed:
    - name: wine
    - require:
      - pkg: sift-wine-apt-update
