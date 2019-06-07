include:
  - ..repos.openjdk

{% if grains['oscodename'] == "trusty" -%}
openjdk:
  pkg.installed:
    - name: openjdk-6-jdk
    - require:
      - pkgrepo: openjdk-repo
{% elif grains['oscodename'] == "xenial" -%}
openjdk: 
  pkg.installed:
    - name: openjdk-7-jdk
    - require:
      - pkgrepo: openjdk-repo
{% elif grains['oscodename'] == "bionic" %}
openjdk: 
  pkg.installed:
    - name: openjdk-8-jdk
{%- endif -%}
