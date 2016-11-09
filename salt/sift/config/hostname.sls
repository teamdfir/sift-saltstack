{%- set hostname = salt['pillar.get']('sift_hostname', 'siftworkstation') -%}
/etc/hostname:
  file.managed:
    - contents: {{ hostname }}
    - backup: false

set-hostname:
  cmd.run:
    {% if grains["init"] == "systemd" %}
    - name: hostnamectl set-hostname {{ hostname }}
    {% else %}
    - name: hostname {{ hostname }}
    {% endif %}
    - unless: test "{{ hostname }}" = "$(hostname)"

set-hosts:
  host.present:
    - name: {{ hostname }}
    - ip: 127.0.0.1
