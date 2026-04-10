{% set codename = grains["oscodename"] %}
{%- if grains["osarch"] == "aarch64" or grains["osarch"] == "arm64" -%}
sift-ubuntu-ports-repo:
  file.append:
    - name: /etc/apt/sources.list.d/ubuntu.sources
    - text: |

        Types: deb
        URIs: http://ports.ubuntu.com/ubuntu-ports/
        Suites: {{ codename }}
        Components: main universe restricted multiverse
        Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
        Architectures: arm64

        Types: deb
        URIs: http://ports.ubuntu.com/ubuntu-ports/
        Suites: {{ codename }}-security
        Components: main universe restricted multiverse
        Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
        Architectures: arm64
    - unless:
      - grep -q "URIs: http://ports.ubuntu.com/ubuntu-ports/" /etc/apt/sources.list.d/ubuntu.sources

{% else %}
{% if not salt['file.file_exists']('/etc/apt/sources.list.d/ubuntu.sources') %}
sift-ubuntu-repo-multiverse:
  file.managed:
    - name: /etc/apt/sources.list.d/ubuntu.sources
    - contents: |
        Types: deb
        URIs: http://ca.archive.ubuntu.com/ubuntu/
        Suites: {{ codename }} {{ codename }}-updates {{ codename }}-backports
        Components: main restricted universe multiverse
        Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
    - mode: 644
{% endif %}

sift-multiverse-repo:
  file.replace:
    - name: /etc/apt/sources.list.d/ubuntu.sources
    - pattern: '^(Components: )(?!.*\bmultiverse\b)(.*)$'
    - repl: '\1\2 multiverse'
    - flags:
        - MULTILINE

sift-security-repo:
  file.append:
    - name: /etc/apt/sources.list.d/ubuntu.sources
    - text: |

        Types: deb
        URIs: http://security.ubuntu.com/ubuntu/
        Suites: {{ codename }}-security
        Components: main universe restricted multiverse
        Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
    - unless:
      - grep -q "^Suites:.*{{ codename }}-security" /etc/apt/sources.list.d/ubuntu.sources

{% endif %}
