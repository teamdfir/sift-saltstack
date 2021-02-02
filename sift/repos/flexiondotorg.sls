include:
  - sift.packages.software-properties-common

flexiondotorg-repo:
  pkgrepo.managed:
    - ppa: flexiondotorg/magnus
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - refresh: true
    - require:
      - sls: sift.packages.software-properties-common
