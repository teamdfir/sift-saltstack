{%- if grains['oscodename'] == "trusty" -%}
sift-universe-repo:
  pkgrepo.managed:
    - humanname: Ubuntu Universal
    - name: deb http://archive.ubuntu.com/ubuntu {{ grains['lsb_distrib_codename'] }} main universe
    - file: /etc/apt/sources.list.d/universe.list
    - gpg_check: 1
    - refresh_db: true
{%- elif grains['oscodename'] == "xenial" -%}
sift-universe-repo:
  pkgrepo.managed:
    - name: deb http://archive.ubuntu.com/ubuntu/ {{ grains['lsb_distrib_codename'] }} universe
    - refresh_db: true
{%- else %}
sift-universe-repo:
  test.nop:
    - name: sift-universe-repo
{%- endif %}
