{%- if grains['oscodename'] == "trusty" -%}
sift-universe-repo:
  pkgrepo.managed:
    - humanname: Ubuntu Universal
    - name: deb http://archive.ubuntu.com/ubuntu {{ grains['lsb_distrib_codename'] }} main universe
    - file: /etc/apt/sources.list.d/universal-xenial.list
    - gpg_check: 1
    - refresh_db: true
{%- endif %}
