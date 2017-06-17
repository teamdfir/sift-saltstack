{%- set files = ['WP8_AppPerms.py','bing-bar-parser.pl','chunkymonkey.py','dextract.def','dextract.py','docx-font-extractor.pl','exif2map.pl','fbmsg-extractor.py','gis4cookie.pl','google-ei-time.py','imgcache-parse-mod.py','imgcache-parse.py','json-printer.pl','msoffice-pic-extractor.py','plist2db.py','print_apk_perms.py','s2-cellid2latlong.py','s2-latlong2cellid.py','sms-grep-sample-config.txt','sms-grep.pl','sqlite-base64-decode.py','sqlite-blob-dumper.py','sqlite-parser.pl','squirrelgripper-README.txt','squirrelgripper.pl','timediff32.pl','vmail-db-2-html.pl','wp8-1-callhistory.py','wp8-1-contacts.py','wp8-1-mms-filesort.py','wp8-1-mms.py','wp8-1-sms.py','wp8-callhistory.py','wp8-contacts.py','wp8-fb-msg.py','wp8-sha256-pin-finder.py','wp8-sms.py','wwf-chat-parser.py'] -%}

include:
  - sift.packages.git
  - sift.packages.python

sift-scripts-4n6-git:
  git.latest:
    - name: https://github.com/cheeky4n6monkey/4n6-scripts.git
    - target: /usr/local/src/4n6-scripts
    - user: root
    - rev: master
    - force_clone: True
    - require:
      - pkg: git
      - pkg: python

{%- for file in files %}
sift-scripts-4n6-{{ file }}:
  file.copy:
    - name: /usr/local/bin/{{ file }}
    - source: /usr/local/src/4n6-scripts/{{ file }}
    - file_mode: 755
    - watch:
      - git: sift-scripts-4n6-git
{%- endfor %}
