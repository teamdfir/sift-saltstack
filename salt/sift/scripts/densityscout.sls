/usr/local/bin/densityscout:
  file.managed:
    - source: salt://sift/files/densityscout/densityscout
    - file_mode: 755
    - replace: True
    - makedirs: True
