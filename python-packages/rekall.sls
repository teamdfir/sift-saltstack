include:
  - sift.packages.libncurses
  - sift.packages.python-virtualenv
  - .pip
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
      - pip: wheel
      - pip: pip
      - pip: setuptools
      - pkg: libncurses
      - virtualenv: rekall-virtualenv
