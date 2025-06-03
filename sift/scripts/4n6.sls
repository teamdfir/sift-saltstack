# Name: 4n6-scripts
# Website: https://github.com/digitalsleuth/4n6-scripts
# Description: A collection of forensics scripts by Cheeky4N6Monkey, updated for Python 3
# Category: 
# Author: Cheeky4N6Monkey / Corey Forman (digitalsleuth)
# License: GNU General Public License v3+ (https://github.com/digitalsleuth/4n6-scripts/blob/master/README.md)
# Notes: 

{% set files = [('Android', ['fbmsg-extractor.py','imgcache-parse-mod.py','imgcache-parse.py','print_apk_perms.py','wwf-chat-parser.py']),
                 ('Ford', ['sync3-unisearch.py','sync3-unisearch2kml.py']),
                 ('Google_Takeout_Records', ['gRecordsActivity_ijson_date.py']),
                 ('Samsung_Gallery3d_2022', ['java-hashcode.py','samsung_gallery3d_filesysmon_parser_v11.py','samsung_gallery3d_log_parser_v10.py','samsung_gallery3d_log_parser_v11.py','samsung_gallery3d_trash_parser_v10.py']),
                 ('WindowsPhone8', ['WP8_AppPerms.py','wp8-1-callhistory.py','wp8-1-contacts.py','wp8-1-mms-filesort.py','wp8-1-mms.py','wp8-1-sms.py','wp8-callhistory.py','wp8-contacts.py','wp8-fb-msg.py','wp8-sha256-pin-finder.py','wp8-sms.py']),
                 ('iOS', ['ios14_maps_history.py','vmail-db-2-html.pl']),
                 ('perl', ['bing-bar-parser.pl','docx-font-extractor.pl','exif2map.pl','gis4cookie.pl','json-printer.pl','sms-grep-sample-config.txt','sms-grep.pl']),
                 ('utilities', ['chunkymonkey.py','dextract.def','dextract.py','google-ei-time.py','msoffice-pic-extractor.py','parse_garmin56LM.py','plist2db.py','s2-cellid2latlong.py','s2-latlong2cellid.py','sqlite-base64-decode.py','sqlite-blob-dumper.py','sqlite-parser.pl','squirrelgripper-README.txt','squirrelgripper.pl','timediff32.pl'])
                ] %}

include:
  - sift.packages.python3-virtualenv
  - sift.packages.git
  - sift.perl-packages.exiftool
  - sift.perl-packages.cgi
  - sift.perl-packages.xpath
  - sift.perl-packages.quicktable
  - sift.perl-packages.json
  - sift.perl-packages.dbi
  - sift.perl-packages.datecalc

sift-python3-package-4n6-scripts-venv:
  virtualenv.managed:
    - name: /opt/4n6-scripts
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - packaging>=22.0.0
      - ijson
      - s2sphere
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-4n6-scripts-git:
  git.latest:
    - name: https://github.com/digitalsleuth/4n6-scripts.git
    - target: /usr/local/src/4n6-scripts
    - user: root
    - rev: master
    - force_clone: True
    - force_reset: True
    - require:
      - sls: sift.packages.git

{% for folder, file_list in files %}
{% for file in file_list %}
{% if file.split('.')[1] == "py" %}

sift-python3-package-4n6-scripts-copy-{{ file }}:
  file.copy:
    - name: /opt/4n6-scripts/bin/{{ file }}
    - source: /usr/local/src/4n6-scripts/{{ folder }}/{{ file }}
    - force: True
    - mode: 755
    - require:
      - git: sift-python3-package-4n6-scripts-git

sift-python3-package-4n6-scripts-shebang-{{ file }}:
  file.replace:
    - name: /opt/4n6-scripts/bin/{{ file }}
    - pattern: '#! /usr/bin/env python3'
    - repl: '#!/opt/4n6-scripts/bin/python3'
    - count: 1
    - require:
      - file: sift-python3-package-4n6-scripts-copy-{{ file }}

sift-python3-package-4n6-scripts-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/4n6-scripts/bin/{{ file }}
    - makedirs: False
    - require:
      - file: sift-python3-package-4n6-scripts-shebang-{{ file }}

sift-python3-package-4n6-scripts-remove-{{ file }}-bak:
  file.absent:
    - name: /opt/4n6-scripts/bin/{{ file }}.bak
    - require:
      - file: sift-python3-package-4n6-scripts-symlink-{{ file }}

{% else %}

sift-python3-package-4n6-scripts-copy-{{ file }}:
  file.copy:
    - name: /usr/local/bin/{{ file }}
    - source: /usr/local/src/4n6-scripts/{{ folder }}/{{ file }}
    - force: True
    - mode: 755
    - require:
      - git: sift-python3-package-4n6-scripts-git

{% endif %}
{% endfor %}
{% endfor %}
