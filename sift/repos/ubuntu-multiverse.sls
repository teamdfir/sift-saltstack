{%- set repo_url = "http://archive.ubuntu.com/ubuntu/ " %}
{%- if grains["osarch"] == "aarch64" or grains["osarch"] == "arm64" -%}
{%- set repo_url = "http://ports.ubuntu.com/ubuntu-ports/" -%}
{%- endif %}

sift-multiverse-repo:
  pkgrepo.managed:
    - humanname: ubuntu-multiverse
    - name: deb {{ repo_url }} {{ grains['lsb_distrib_codename'] }} multiverse
    - refresh_db: true

sift-multiverse-repo-security:
  pkgrepo.managed:
    - humanname: ubuntu-multiverse-security
    - name: deb {{ repo_url }} {{ grains['lsb_distrib_codename'] }}-security multiverse
    - refresh_db: true

