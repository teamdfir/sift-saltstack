include:
  - sift.repos.openjdk

openjdk: 
  pkg.installed:
    - name: openjdk-8-jdk
    - require:
      - sls: sift.repos.openjdk

