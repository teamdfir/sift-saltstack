{% if grains['oscodename'] == "focal" %}
include:
  - sift.repos.microsoft

dotnet6-install:
  pkg.installed:
    - name: dotnet-sdk-6.0
    - require:
      - sls: sift.repos.microsoft

{% elif grains['oscodename'] == "jammy" %}
sift-package-dotnet6:
  pkg.installed:
    - name: dotnet-sdk-6.0

{% endif %}
