include:
  - sift.packages.default-jre
  - sift.packages.libcommons-lang3-java
  - sift.packages.libbcprov-java

sift-package-pdftk-java:
  pkg.installed:
    - sources: 
        - pdftk-java: http://mirrors.edge.kernel.org/ubuntu/pool/universe/p/pdftk-java/pdftk-java_3.2.2-1_all.deb
    - require:
        - sls: sift.packages.default-jre
        - sls: sift.packages.libcommons-lang3-java
        - sls: sift.packages.libbcprov-java
