{%- set files = ['WP8_AppPerms.py','bing-bar-parser.pl','chunkymonkey.py','dextract.def','dextract.py','docx-font-extractor.pl','exif2map.pl','fbmsg-extractor.py','gis4cookie.pl','google-ei-time.py','imgcache-parse-mod.py','imgcache-parse.py','json-printer.pl','msoffice-pic-extractor.py','plist2db.py','print_apk_perms.py','s2-cellid2latlong.py','s2-latlong2cellid.py','sms-grep-sample-config.txt','sms-grep.pl','sqlite-base64-decode.py','sqlite-blob-dumper.py','sqlite-parser.pl','squirrelgripper-README.txt','squirrelgripper.pl','timediff32.pl','vmail-db-2-html.pl','wp8-1-callhistory.py','wp8-1-contacts.py','wp8-1-mms-filesort.py','wp8-1-mms.py','wp8-1-sms.py','wp8-callhistory.py','wp8-contacts.py','wp8-fb-msg.py','wp8-sha256-pin-finder.py','wp8-sms.py','wwf-chat-parser.py'] %}
{%- set noshebang = ['sqlite-base64-decode.py','sqlite-blob-dumper.py','wp8-sha256-pin-finder.py'] %}

include:
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
    - rev: d1f629ecd1f5d0578d91a5c4a89fe2b10801dc43
    - force_clone: True
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python2
      - sls: sift.packages.python3

{%- for file in files %}
sift-scripts-4n6-{{ file }}:
  file.copy:
    - name: /usr/local/bin/{{ file }}
    - source: /usr/local/src/4n6-scripts/{{ file }}
    - force: True
    - mode: 755
    - watch:
      - git: sift-scripts-4n6-git
{%- endfor %}

{%- for file in files %}
sift-scripts-4n6-python-{{ file }}:
  file.replace:
    - name: /usr/local/bin/{{ file }}
    - pattern: '#! /usr/bin/env python\n'
    - repl: '#!/usr/bin/env python2\n'
    - count: 1
    - watch:
      - git: sift-scripts-4n6-git
{%- endfor %}

sift-scripts-4n6-plistdb2py-shebang:
  file.prepend:
    - name: /usr/local/bin/plist2db.py
    - text: '#!/usr/bin/env python3'
    - watch:
      - git: sift-scripts-4n6-git

{%- for file in noshebang %}
sift-scripts-4n6-add-shebang-{{ file }}:
  file.prepend:
    - name: /usr/local/bin/{{ file }}
    - text: '#!/usr/bin/env python2'
    - watch:
      - git: sift-scripts-4n6-git
{%- endfor %}

