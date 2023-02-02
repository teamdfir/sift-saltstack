include:
  - sift.repos.docker
  - sift.repos.gift
  {% if grains['oscodename'] != "jammy" %}
  - sift.repos.sift
  {% endif %}
  - sift.repos.openjdk
  - sift.repos.ubuntu-multiverse
  - sift.repos.ubuntu-universe


sift-repos:
  test.nop:
    - name: sift-repos
    - require:
      - sls: sift.repos.docker
      - sls: sift.repos.gift
      {% if grains['oscodename'] != "jammy" %}
      - sls: sift.repos.sift
      {% endif %}
      - sls: sift.repos.openjdk
      - sls: sift.repos.ubuntu-multiverse
      - sls: sift.repos.ubuntu-universe
      
