include:
  - sift.packages.perl

sift-tools-windows-forensic-analysis-jumplist:
  file.managed:
    - name: /usr/share/perl5/JumpList.pm
    - source: salt://sift/files/windows-forensic-analysis/JumpList.pm
    - required:
      - sls: sift.packages.perl

sift-tools-windows-forensic-analysis-lnk:
  file.managed:
    - name: /usr/share/perl5/LNK.pm
    - source: salt://sift/files/windows-forensic-analysis/LNK.pm
    - required:
      - sls: sift.packages.perl

sift-tools-windows-forensic-analysis-pref:
  file.managed:
    - name: /usr/share/perl5/Pref.pm
    - source: salt://sift/files/windows-forensic-analysis/pref.pm
    - required:
      - sls: sift.packages.perl
