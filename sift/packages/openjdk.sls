include:
  - sift.repos.openjdk

sift-package-openjdk-8-jdk: 
  pkg.installed:
    - name: openjdk-8-jdk
    - require:
      - sls: sift.repos.openjdk

