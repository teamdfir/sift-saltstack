include:
  - sift.packages.build-essential
  - sift.packages.python-dev
  - sift.packages.python-pip
  - sift.packages.libncurses
  - sift.packages.python-virtualenv
  - sift.python-packages.setuptools
  - sift.python-packages.wheel

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
