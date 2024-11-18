{%- set commit = "038e8ec836cf23600124db74b40757b7184c08c5" -%}
{% set files = ['INDXParse.py','MFTINDX.py','MFTView.py','SDS_get_index.py','extract_mft_record_slack.py','fuse-mft.py','get_file_info.py','list_mft.py','tree_mft.py'] %}

include:
  - sift.packages.python3-virtualenv
  - sift.packages.git
  - sift.packages.python3-dev
  - sift.packages.libgtk-3-dev
  - sift.packages.pkg-config
  - sift.packages.build-essential
  - sift.packages.libfuse-dev
  - sift.packages.python3-wxgtk4

sift-python3-package-indxparse-venv:
  virtualenv.managed:
    - name: /opt/indxparse
    - venv_bin: /usr/bin/virtualenv
    - system_site_packages: True
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - fuse-python
      - importlib_metadata>=8.0.0
    - require:
      - sls: sift.packages.python3-virtualenv
      - sls: sift.packages.python3-dev
      - sls: sift.packages.libgtk-3-dev
      - sls: sift.packages.pkg-config
      - sls: sift.packages.build-essential
      - sls: sift.packages.libfuse-dev
      - sls: sift.packages.python3-wxgtk4

sift-python3-package-indxparse:
  pip.installed:
    - name: git+https://github.com/williballenthin/INDXParse.git@{{ commit }}
    - bin_env: /opt/indxparse/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-indxparse-venv
      - sls: sift.packages.git

{% for file in files %}
sift-python3-package-indxparse-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/indxparse/bin/{{ file }}
    - makedirs: False
    - require:
      - pip: sift-python3-package-indxparse
{% endfor %}
