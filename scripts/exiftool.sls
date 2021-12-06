# source=https://owl.phy.queensu.ca/~phil/exiftool/
# license=free

{% set exiftool_version = '10.60' -%}
{% set exiftool_sha256  = 'df0988f60e1a6c086799e1f2ecd419e8abbad4dfb5dfa66c6080c78a5cb7acfa' -%}

include:
  - sift.packages.patch
  
sift-exiftool-source:
  file.managed:
    - name: /var/cache/sift/archives/Image-ExifTool-{{ exiftool_version }}.tar.gz
    - source: https://owl.phy.queensu.ca/~phil/exiftool/Image-ExifTool-{{ exiftool_version }}.tar.gz
    - source_hash: sha256={{ exiftool_sha256 }}
    - makedirs: True

sift-exiftool-extracted:
  archive.extracted:
    - name: /usr/local/src/exiftool-{{ exiftool_version }}
    - source: /var/cache/sift/archives/Image-ExifTool-{{ exiftool_version }}.tar.gz
    - source_hash: sha256={{ exiftool_sha256 }}
    - watch:
      - file: sift-exiftool-source

sift-exiftool-patch-file:
  file.managed:
    - name: /usr/local/src/exiftool-{{ exiftool_version }}/exiftool.patch
    - contents: |
        diff --git 1/exiftool 2/exiftool
        index eeff10b..a7c1259 100755
        --- 1/exiftool
        +++ 2/exiftool
        @@ -18,7 +18,7 @@ my $version = '10.60';
         my $exeDir;
         BEGIN {
             # get exe directory
        -    $exeDir = ($0 =~ /(.*)[\\\/]/) ? $1 : '.';
        +    $exeDir = "/usr/local/share/exiftool-$version/Image-ExifTool-$version";
             # add lib directory at start of include path
             unshift @INC, "$exeDir/lib";
             # load or disable config file if specified
    - watch:
      - archive: sift-exiftool-extracted

sift-exiftool-patch:
  file.patch:
    - name: /usr/local/src/exiftool-{{ exiftool_version }}/Image-ExifTool-{{ exiftool_version }}/exiftool
    - source: /usr/local/src/exiftool-{{ exiftool_version }}/exiftool.patch
    - hash: sha256=8790e165825aa7028d3a71ce656c876f8430d2505c6ca5aa058e74b16faee611
    - require:
      - sls: sift.packages.patch
      - file: sift-exiftool-patch-file
    - watch:
      - archive: sift-exiftool-extracted

sift-exiftool-binary:
  file.managed:
    - name: /usr/local/bin/exiftool
    - source: /usr/local/src/exiftool-{{ exiftool_version }}/Image-ExifTool-{{ exiftool_version }}/exiftool
    - mode: 755
    - watch:
      - file: sift-exiftool-patch


  
