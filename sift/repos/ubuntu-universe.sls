{%- set repo_url = "http://archive.ubuntu.com/ubuntu/ " %}
{%- if grains["osarch"] == "aarch64" or grains["osarch"] == "arm64" -%}
{%- set repo_url = "http://ports.ubuntu.com/ubuntu-ports/" -%}
{%- endif %}

sift-universe-repo:
  pkgrepo.managed:
    - humanname: ubuntu-universe
    - name: deb {{ repo_url }} {{ grains['lsb_distrib_codename'] }} universe
    - refresh_db: true
