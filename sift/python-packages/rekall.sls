include:
  - ..packages.build-essential
  - ..packages.python-dev
  - ..packages.python-pip
  - ..packages.libncurses
  - ..packages.python-virtualenv
  - .setuptools
  - .wheel

rekall-virtualenv:
  virtualenv.managed:
    - name: /opt/rekall
    - pip_pkgs:
      - pip
      - setuptools
      - wheel
      - rekall
    - require:
      - pkg: python-virtualenv

rekall:
  pip.installed:
    - name: rekall
    - bin_env: /opt/rekall
    - require:
      - pkg: python-dev
      - pkg: python-pip
      - pkg: libncurses
      - pkg: build-essential
      - pip: setuptools
      - pip: wheel
      - virtualenv: rekall-virtualenv

rekall-symlink:
  file.symlink:
    - name: /usr/local/bin/rekall
    - target: /opt/rekall/bin/rekall
    - require:
      - pip: rekall
