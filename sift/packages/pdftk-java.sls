include:
  - sift.repos.ubuntu-universe
  - sift.packages.default-jre
  - sift.packages.libcommons-lang3-java
  - sift.packages.libbcprov-java

sift-packages-pdftk-java:
  pkg.installed:
    - name: pdftk-java  
    - require:
        - sls: sift.packages.default-jre
        - sls: sift.packages.libcommons-lang3-java
        - sls: sift.packages.libbcprov-java
        - sls: sift.repos.ubuntu-universe
