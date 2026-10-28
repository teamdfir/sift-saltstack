{% set codename = grains["oscodename"] %}
{% set is_arm = grains["osarch"] in ["arm64", "aarch64"] %}
{% set keyring = "/usr/share/keyrings/ubuntu-archive-keyring.gpg" %}
{% set mirror = "http://ports.ubuntu.com/ubuntu-ports/" if is_arm else "http://archive.ubuntu.com/ubuntu/" %}
{% set pockets = [codename, codename ~ "-updates", codename ~ "-backports"] + ([codename ~ "-security"] if is_arm else []) %}

sift-ubuntu-sources:
  file.managed:
    - name: /etc/apt/sources.list.d/ubuntu.sources
    - replace: False
    - makedirs: True
    - mode: '0644'
    - contents: |
        Types: deb
        URIs: {{ mirror }}
        Suites: {{ pockets | join(" ") }}
        Components: main restricted
        Signed-By: {{ keyring }}
        {%- if is_arm %}
        Architectures: arm64
        {%- else %}

        Types: deb
        URIs: http://security.ubuntu.com/ubuntu/
        Suites: {{ codename }}-security
        Components: main restricted
        Signed-By: {{ keyring }}
        {%- endif %}
    - onchanges_in:
      - module: sift-ubuntu-repo-refresh

{% if codename == "jammy" %}
sift-remove-sources-list:
  file.absent:
    - name: /etc/apt/sources.list
    - require:
      - file: sift-ubuntu-sources
    - onchanges_in:
      - module: sift-ubuntu-repo-refresh
{% endif %}

sift-ubuntu-repo-refresh:
  module.run:
    - pkg.refresh_db:
