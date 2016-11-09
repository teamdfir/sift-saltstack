{%- if grains['oscodename'] != "xenial" -%}
libafflib:
  pkg.installed:
    - name: libafflib0
{%- elif grains['oscodename'] == "xenial" -%}
libafflib:
  pkg.installed:
    - name: libafflib0v5
{%- endif -%}
