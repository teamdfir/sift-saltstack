include:
  - sift.packages.python-pip

bitstring:
  pip.installed:
    {% if grains['oscodename'] == "bionic" -%}
    - pip_bin: /usr/bin/pip
    {% endif -%}
    - require:
      - pkg: python-pip
