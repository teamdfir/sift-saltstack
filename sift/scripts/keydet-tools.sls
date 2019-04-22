# source=https://github.com/keydet89/Tools.git
# license=unknown

{% set files = ['bodyfile.pl','evtparse.pl','evtrpt.pl','evtxparse.pl','fb.pl','ff.pl','ff_signons.pl','ftkparse.pl','idx.pl','idxparse.pl','jl.pl','jobparse.pl','lfle.pl','lnk.pl','mft.pl','parse.pl','parsei30.pl','parseie.pl','pie.pl','pref.pl','rawie.pl','recbin.pl','regslack.pl','regtime.pl','rfc.pl','rlo.pl','tln.pl','usnj.pl'] -%}

include:
  - sift.packages.git

sift-scripts-keydet-tools-git:
  git.latest:
    - name: https://github.com/keydet89/Tools.git
    - target: /usr/local/src/keydet-tools
    - user: root
    - rev: master
    - force_clone: True
    - require:
      - pkg: git

{%- for file in files %}
sift-scripts-keydet-tools-{{ file }}:
  file.copy:
    - name: /usr/local/bin/{{ file }}
    - source: /usr/local/src/keydet-tools/source/{{ file }}
    - force: True
    - mode: 0755
    - require:
      - git: sift-scripts-keydet-tools-git

sift-scripts-keydet-tools-shebang-{{ file }}:
  file.replace:
    - name: /usr/local/bin/{{ file }}
    - pattern: '#!(.*)'
    - repl: '#!/usr/bin/env perl'
    - count: 1
    - watch:
      - file: sift-scripts-keydet-tools-{{ file }}
{%- endfor %}

