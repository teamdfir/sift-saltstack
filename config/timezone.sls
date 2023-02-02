{%- set timezone = salt['pillar.get']('sift_timezone', 'Etc/UTC') -%}

{{ timezone }}:
  timezone.system
