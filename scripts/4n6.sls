{% set files = [('Android', ['fbmsg-extractor.py','imgcache-parse-mod.py','imgcache-parse.py','print_apk_perms.py','wwf-chat-parser.py']),
                 ('Ford', ['sync3-unisearch.py','sync3-unisearch2kml.py']),
                 ('Google_Takeout_Records', ['gRecordsActivity_ijson_date.py']),
                 ('Samsung_Gallery3d_2022', ['java-hashcode.py','samsung_gallery3d_filesysmon_parser_v11.py','samsung_gallery3d_log_parser_v10.py','samsung_gallery3d_log_parser_v11.py','samsung_gallery3d_trash_parser_v10.py']),
                 ('WindowsPhone8', ['WP8_AppPerms.py','wp8-1-callhistory.py','wp8-1-contacts.py','wp8-1-mms-filesort.py','wp8-1-mms.py','wp8-1-sms.py','wp8-callhistory.py','wp8-contacts.py','wp8-fb-msg.py','wp8-sha256-pin-finder.py','wp8-sms.py']),
                 ('iOS', ['ios14_maps_history.py','vmail-db-2-html.pl']),
                 ('perl', ['bing-bar-parser.pl','docx-font-extractor.pl','exif2map.pl','gis4cookie.pl','json-printer.pl','sms-grep-sample-config.txt','sms-grep.pl']),
                 ('utilities', ['chunkymonkey.py','dextract.def','dextract.py','google-ei-time.py','msoffice-pic-extractor.py','parse_garmin56LM.py','plist2db.py','s2-cellid2latlong.py','s2-latlong2cellid.py','sqlite-base64-decode.py','sqlite-blob-dumper.py','sqlite-parser.pl','squirrelgripper-README.txt','squirrelgripper.pl','timediff32.pl'])
                ] %}

{% set noshebang = ['sqlite-base64-decode.py','sqlite-blob-dumper.py','wp8-sha256-pin-finder.py'] %}
{% set fixshebangpy2 = ['fbmsg-extractor.py','imgcache-parse-mod.py','imgcache-parse.py','print_apk_perms.py','wwf-chat-parser.py','WP8_AppPerms.py','wp8-1-callhistory.py','wp8-1-contacts.py','wp8-1-mms-filesort.py','wp8-1-mms.py','wp8-1-sms.py','wp8-callhistory.py','wp8-contacts.py','wp8-fb-msg.py','wp8-sms.py','chunkymonkey.py','dextract.py','google-ei-time.py','msoffice-pic-extractor.py','s2-cellid2latlong.py','s2-latlong2cellid.py'] %}
{% set fixshebangpy3 = ['sync3-unisearch.py','sync3-unisearch2kml.py','gLocationHistoryActivity.py','gRecordsActivity_ijson_date.py','java-hashcode.py','samsung_gallery3d_filesysmon_parser_v11.py','samsung_gallery3d_log_parser_v10.py','samsung_gallery3d_log_parser_v11.py','samsung_gallery3d_trash_parser_v10.py'] %}

include:
  - sift.python3-packages.ijson
  - sift.python-packages.s2sphere
  - sift.packages.git
  - sift.packages.python2
  - sift.packages.python3
  - sift.perl-packages.exiftool
  - sift.perl-packages.cgi
  - sift.perl-packages.xpath
  - sift.perl-packages.quicktable
  - sift.perl-packages.json
  - sift.perl-packages.dbi
  - sift.perl-packages.datecalc

sift-scripts-4n6-git:
  git.latest:
    - name: https://github.com/cheeky4n6monkey/4n6-scripts.git
    - target: /usr/local/src/4n6-scripts
    - user: root
    - rev: f57a5301b317a9842c0d43853595161843086923
    - force_clone: True
    - force_reset: True
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python2
      - sls: sift.packages.python3

{% for folder, file_list in files %}
{%  for file in file_list %}
sift-scripts-4n6-{{ file }}:
  file.copy:
    - name: /usr/local/bin/{{ file }}
    - source: /usr/local/src/4n6-scripts/{{ folder }}/{{ file }}
    - force: True
    - mode: 755
    - watch:
      - git: sift-scripts-4n6-git
{% endfor %}
{% endfor %}

sift-scripts-4n6-gLocationHistoryActivity:
  file.copy:
    - name: /usr/local/bin/gLocationHistoryActivity.py
    - source: '/usr/local/src/4n6-scripts/Google_Takeout_Location_History/# gLocationHistoryActivity.py'
    - force: True
    - mode: 755
    - watch:
      - git: sift-scripts-4n6-git

{% for file in fixshebangpy2 %}
sift-scripts-4n6-python2-{{ file }}:
  file.replace:
    - name: /usr/local/bin/{{ file }}
    - pattern: '#! /usr/bin/env python\n'
    - repl: '#! /usr/bin/env python2\n'
    - count: 1
    - watch:
      - git: sift-scripts-4n6-git
{% endfor %}

{% for file in fixshebangpy3 %}
sift-scripts-4n6-python3-{{ file }}:
  file.replace:
    - name: /usr/local/bin/{{ file }}
    - pattern: '#! /usr/bin/env python\n'
    - repl: '#! /usr/bin/env python3\n'
    - count: 1
    - watch:
      - git: sift-scripts-4n6-git
{% endfor %}

{% for file in fixshebangpy3 %}
sift-scripts-4n6-python3-CRLF{{ file }}:
  file.replace:
    - name: /usr/local/bin/{{ file }}
    - pattern: '#! /usr/bin/env python\r'
    - repl: '#! /usr/bin/env python3\n'
    - count: 1
    - watch:
      - git: sift-scripts-4n6-git
{% endfor %}

{%- for file in noshebang %}
sift-scripts-4n6-add-shebang-{{ file }}:
  file.prepend:
    - name: /usr/local/bin/{{ file }}
    - text: '#!/usr/bin/env python2'
    - watch:
      - git: sift-scripts-4n6-git
{% endfor %}

sift-scripts-4n6-plistdb2py-shebang:
  file.prepend:
    - name: /usr/local/bin/plist2db.py
    - text: '#!/usr/bin/env python3'
    - watch:
      - git: sift-scripts-4n6-git

