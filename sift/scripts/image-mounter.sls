# Source: https://github.com/kevthehermit/Scripts
sift-scripts-image-mounter:
  file.managed:
    - name: /usr/local/bin/imageMounter.py
    - source: https://raw.githubusercontent.com/kevthehermit/Scripts/master/imageMounter.py
    - source_hash: sha256=7e810482b5aa58f8085a7a03be266c113530145306c73c75ba9956ba83e39151
    - mode: 755
