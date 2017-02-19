include:
  - ..repos.openjdk

{%- if grains['oscodename'] == "trusty" -%}
openjdk:
  pkg.installed:
    - name: openjdk-6-jdk
    - require:
      - pkgrepo: openjdk
{%- elif grains['oscodename'] == "xenial" -%}
openjdk: 
  pkg.installed:
    - name: openjdk-7-jdk
    - require:
      - pkgrepo: openjdk
{%- endif -%}
