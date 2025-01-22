include:
  - sift.packages.software-properties-common

sift-dotnet-backports-repo:
  pkgrepo.managed:
    - name: dotnet-backports
    - ppa: dotnet/backports
    - keyid: 45A3F127159BE9E5017811C62125B164E8E5D3FA
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - refresh: true
    - require:
      - sls: sift.packages.software-properties-common
