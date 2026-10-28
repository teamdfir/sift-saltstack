include:
  - sift.repos.adoptium

sift-package-temurin-jdk: 
  pkg.installed:
    - name: temurin-8-jdk
    - require:
      - sls: sift.repos.adoptium

