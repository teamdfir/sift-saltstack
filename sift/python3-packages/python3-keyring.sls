{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = "/home/" + user -%}
{%- endif -%}

include:
  - sift.config.user

{% if not salt['file.file_exists']( home + '/.config/python_keyring/keyringrc.cfg') %}

disable-python3-keyring:
  file.managed:
    - name: {{ home }}/.config/python_keyring/keyringrc.cfg
    - user: {{ user }}
    - group: {{ user }}
    - mode: 664
    - contents: |
        [backend]
        default-keyring=keyring.backends.null.Keyring
    - contents_newline: False
    - makedirs: True

export-keyring-backend:
  cmd.run:
    - name: 'export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring'
    - env:
      - PYTHON_KEYRING_BACKEND: keyring.backends.null.Keyring
    - runas: {{ user }}

export-keyring-backend-setenv:
  environ.setenv:
    - name: PYTHON_KEYRING_BACKEND
    - value: keyring.backends.null.Keyring

{% else %}

python3-keyring-exists:
  test.nop

{% endif %}
