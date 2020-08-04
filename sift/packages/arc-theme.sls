{%- if grains['oscodename'] == "bionic" %}
include:
  - sift.repos.noobslab

sift-package-arc-theme:
  pkg.installed:
    - name: arc-theme
    - require:
      - pkgrepo: sift-repo-noobslab-themes
{%- else %}
sift-package-arc-theme:
  test.nop
{%- endif %}