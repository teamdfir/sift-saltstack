{% if grains['osarch'] == "amd64" %}

include:
  - sift.repos.sift

liblightgrep:
  pkg.installed:
    - name: liblightgrep
    - require:
      - sls: sift.repos.sift

{% else %}

not-supported-liblightgrep:
  test.nop

{% endif %}
