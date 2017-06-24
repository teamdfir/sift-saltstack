sift-wine-i386-arch:
  cmd.run:
    - name: dpkg --add-architecture i386
    - unless: dpkg --print-foreign-architectures | grep i386

sift-wine:
  pkg.installed:
    - name: wine
    - require:
      - cmd: sift-wine-i386-arch
