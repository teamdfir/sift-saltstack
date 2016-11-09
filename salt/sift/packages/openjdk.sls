{%- if grains['oscodename'] == "trusty" -%}
openjdk:
  pkg.installed:
    - name: openjdk-6-jdk
{%- elif grains['oscodename'] == "xenial" -%}
openjdk: 
  pkg.installed:
    - name: openjdk-7-jdk
{%- endif -%}
