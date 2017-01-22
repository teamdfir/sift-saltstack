volatility-plugins:
  file.recurse:
    - name: /usr/lib/python2.7/dist-packages/volatility/plugins
    - source: salt://sift/files/volatility
    - file_mode: 644
    - include_pat: '*.py'

/usr/lib/python2.7/dist-packages/volatility/plugins/javarat.py:
  file.absent
