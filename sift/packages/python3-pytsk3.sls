{% if grains['oscodename'] != 'noble' %}

include:
  - sift.repos.gift

sift-package-removed-pytsk3:
  pkg.removed:
    - name: pytsk3

sift-package-python-pytsk3:
  pkg.installed:
    - name: python3-pytsk3
    - required:
      - pkg: sift-package-removed-pytsk3
      - sls: sift.repos.gift

{% else %}
sift-package-python3-tsk:
  pkg.installed:
    - name: python3-tsk
{% endif %}
