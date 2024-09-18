include:
  - sift.repos
  - sift.packages
  {% if grains['osrelease'] == '22.04' %}
  - sift.python-packages
  - sift.python3-packages
  {% endif %}
  {% if grains['osrelease'] == '24.04' %}
  - sift.apps
  {% endif %}
  - sift.perl-packages
  - sift.scripts

sift-server-include:
  test.nop:
    - name: sift-server-include
    - require:
      - sls: sift.repos
      - sls: sift.packages
      {% if grains['osrelease'] == '22.04' %}
      - sls: sift.python-packages
      - sls: sift.python3-packages
      {% endif %}
      {% if grains['osrelease'] == '24.04' %}
      - sls: sift.apps
      {% endif %}
      - sls: sift.perl-packages
      - sls: sift.scripts
