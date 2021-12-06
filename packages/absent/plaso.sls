{% if salt['pkg.version']('python-plaso') == "1.4.0-1ppa3~xenial" %}
python-plaso-1.4.0-hold-fix:
  pkg.installed:
    - name: python-plaso
    - version: 1.4.0-1ppa3~xenial
    - hold: False
    - update_holds: True
    - allow_updates: True
    - require_in:
      - pkg: python-plaso-1.4.0-removed
{% endif %}

{% if salt['pkg.version']('python-dfvfs') == "20160108-1ppa1~xenial" %}
python-dfvfs-20160108-hold-fix:
  pkg.installed:
    - name: python-dfvfs
    - version: 20160108-1ppa1~xenial
    - hold: False
    - update_holds: True
    - allow_updates: True
    {% if salt['pkg.version']('python-plaso') == "1.4.0-1ppa3~xenial" %}
    - require:
      - pkg: python-plaso-1.4.0-hold-fix
    {% endif %}
    - require_in:
      - pkg: python-dfvfs-20160108-removed
{% endif %}

python-plaso-1.4.0-removed:
  pkg.removed:
    - name: python-plaso
    - version: 1.4.0-1ppa3~xenial
    - hold: False
    - update_holds: True
    - allow_updates: True

python-dfvfs-20160108-removed:
  pkg.removed:
    - name: python-dfvfs
    - version: 20160108-1ppa1~xenial
    - hold: False
    - update_holds: True
    - allow_updates: True
    - require:
      - pkg: python-plaso-1.4.0-removed

python-plaso-py2-removed:
  pkg.removed:
    - name: python-plaso
    - version: 20191203-1ppa1~bionic
    - hold: False
    - update_holds: True
    - allow_updates: True