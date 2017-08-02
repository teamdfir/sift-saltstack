include:
  - sift.packages.perl

sift-perl-encode:
  module.wait:
    - name: cpan.install
    - module: encode
    - watch:
      - sls: sift.packages.perl
    
