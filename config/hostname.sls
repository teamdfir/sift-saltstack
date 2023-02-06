{%- set hostname = salt['pillar.get']('sift_hostname', 'siftworkstation') -%}
hostname-managed:
  file.managed:
    - name: /etc/hostname
    - contents: {{ hostname }}
    - backup: false

hostname-set-hostname:
  cmd.run:
    {% if grains["init"] == "systemd" %}
    - name: hostnamectl set-hostname {{ hostname }}
    {% else %}
    - name: hostname {{ hostname }}
    {% endif %}
    - unless: test "{{ hostname }}" = "$(hostname)"

hostname-set-hosts:
  host.present:
    - name: {{ hostname }}
    - ip: 127.0.0.1
