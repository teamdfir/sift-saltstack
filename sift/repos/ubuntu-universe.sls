{% set codename = grains["oscodename"] %}
{%- if grains["osarch"] == "aarch64" or grains["osarch"] == "arm64" -%}
sift-ubuntu-ports-repo-universe:
  file.append:
    - name: /etc/apt/sources.list.d/ubuntu.sources
    - text: |

        Types: deb
        URIs: http://ports.ubuntu.com/ubuntu-ports/
        Suites: {{ codename }}
        Components: main universe restricted multiverse
        Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
        Architectures: arm64
    - makedirs: True
    - unless:
      - grep -q "ubuntu-ports" /etc/apt/sources.list.d/ubuntu.sources
{% else %}
sift-ubuntu-repo-universe:
  file.append:
    - name: /etc/apt/sources.list.d/ubuntu.sources
    - text: |
        Types: deb
        URIs: http://archive.ubuntu.com/ubuntu/
        Suites: {{ codename }} {{ codename }}-updates {{ codename }}-backports
        Components: main restricted universe multiverse
        Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
    - makedirs: True
    - unless:
      - grep -q "archive.ubuntu.com" /etc/apt/sources.list.d/ubuntu.sources

sift-universe-repo:
  file.replace:
    - name: /etc/apt/sources.list.d/ubuntu.sources
    - pattern: '^(Components: )(?!.*\buniverse\b)(.*)$'
    - repl: '\1\2 universe'
    - flags:
        - MULTILINE

{% if codename == "jammy" %}

sift-remove-sources-list:
  file.absent:
    - name: /etc/apt/sources.list
    - require:
      - file: sift-universe-repo

{% endif %}
{% endif %}

