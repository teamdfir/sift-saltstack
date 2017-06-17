include:
  - sift.packages.git
  - sift.packages.python

sift-scripts-4n6-git:
  git.latest:
    - name: https://github.com/cheeky4n6monkey/4n6-scripts.git
    - target: /usr/local/bin/src/4n6-scripts
    - user: root
    - rev: master
    - force_clone: True
    - require:
      - pkg: git
      - pkg: python

sift-scripts-4n6-recurse:
  file.recurse:
    - name: /usr/local/bin
    - source: /usr/local/bin/src/4n6-scripts
    - file_mode: 755
    - watch:
      - git: sift-scripts-4n6-git
