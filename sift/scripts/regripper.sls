# Name: regripper
# Website: https://github.com/keydet89/RegRipper3.0
# Description: Registry parsing toolsuite
# Category: 
# Author: Harlan Carvey
# License: MIT License (https://github.com/keydet89/RegRipper3.0/blob/master/license.md)
# Notes: rip.pl

include:
  - sift.packages.git
  - sift.packages.libparse-win32registry-perl

sift-scripts-regripper-git:
  git.latest:
    - name: https://github.com/keydet89/RegRipper3.0.git
    - target: /usr/local/src/regripper
    - user: root
    - rev: master
    - force_clone: True
    - force_reset: True
    - require:
      - pkg: git

sift-scripts-regripper-directory:
  file.directory:
    - name: /usr/share/regripper
    - makedirs: True
    - file_mode: 644
    - require:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-binary:
  file.managed:
    - name: /usr/share/regripper/rip.pl
    - source: /usr/local/src/regripper/rip.pl
    - mode: 755
    - require:
      - git: sift-scripts-regripper-git
      - pkg: libparse-win32registry-perl

sift-scripts-regripper-perl-header:
  file.replace:
    - name: /usr/share/regripper/rip.pl
    - pattern: '#! c:\\perl\\bin\\perl.exe'
    - repl: '#!/usr/bin/perl'
    - count: 1
    - prepend_if_not_found: True
    - require:
      - file: sift-scripts-regripper-binary

sift-scripts-regripper-plugins-path:
  file.replace:
    - name: /usr/share/regripper/rip.pl
    - pattern: 'my \$plugindir;'
    - repl: 'my $plugindir = "/usr/share/regripper/plugins/";'
    - count: 1
    - prepend_if_not_found: False
    - require:
      - file: sift-scripts-regripper-binary

sift-scripts-regripper-plugins-path-cleanup:
  file.replace:
    - name: /usr/share/regripper/rip.pl
    - pattern: '\(\$\^O eq "MSWin32"\) \? \(\$plugindir = \$str."plugins/"\)'
    - repl: '#($^O eq "MSWin32") ? ($plugindir = $str."plugins/")'
    - count: 1
    - prepend_if_not_found: False
    - require:
      - file: sift-scripts-regripper-binary

sift-scripts-regripper-plugins-cleanup-2:
  file.replace:
    - name: /usr/share/regripper/rip.pl
    - pattern: ': \(\$plugindir = File::Spec->catfile\(\$str, "plugins"\)\);'
    - repl: '#: ($plugindir = File::Spec->catfile($str, "plugins"));'
    - count: 1
    - prepend_if_not_found: False
    - require:
      - file: sift-scripts-regripper-binary

sift-scripts-regripper-plugins-symlink:
  file.symlink:
    - name: /usr/share/regripper/plugins
    - target: /usr/local/src/regripper/plugins
    - require: 
      - git: sift-scripts-regripper-git
      - file: sift-scripts-regripper-directory

sift-scripts-regripper-binary-symlink:
  file.symlink:
    - name: /usr/local/bin/rip.pl
    - target: /usr/share/regripper/rip.pl
    - mode: 755
    - require:
      - file: sift-scripts-regripper-binary

sift-scripts-regripper-plugins-all:
  cmd.wait:
    - name: "grep -R \"my %config = (hive\" /usr/share/regripper/plugins | grep \"All\" | cut -f1 -d: | xargs -n1 -I{} basename {} | sed 's/.pl$//' > /usr/share/regripper/plugins/all"
    - watch:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-plugins-ntuser:
  cmd.wait:
    - name: "grep -R \"my %config = (hive\" /usr/share/regripper/plugins | grep \"NTUSER\" | cut -f1 -d: | xargs -n1 -I{} basename {} | sed 's/.pl$//' > /usr/share/regripper/plugins/ntuser"
    - watch:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-plugins-usrclass:
  cmd.wait:
    - name: "grep -R \"my %config = (hive\" /usr/share/regripper/plugins | grep \"USRCLASS\" | cut -f1 -d: | xargs -n1 -I{} basename {} | sed 's/.pl$//' > /usr/share/regripper/plugins/usrclass"
    - watch:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-plugins-sam:
  cmd.wait:
    - name: "grep -R \"my %config = (hive\" /usr/share/regripper/plugins | grep \"SAM\" | cut -f1 -d: | xargs -n1 -I{} basename {} | sed 's/.pl$//' > /usr/share/regripper/plugins/sam"
    - watch:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-plugins-security:
  cmd.wait:
    - name: "grep -R \"my %config = (hive\" /usr/share/regripper/plugins | grep \"Security\" | cut -f1 -d: | xargs -n1 -I{} basename {} | sed 's/.pl$//' > /usr/share/regripper/plugins/security"
    - watch:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-plugins-software:
  cmd.wait:
    - name: "grep -R \"my %config = (hive\" /usr/share/regripper/plugins | grep \"Software\" | cut -f1 -d: | xargs -n1 -I{} basename {} | sed 's/.pl$//' > /usr/share/regripper/plugins/software"
    - watch:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-plugins-system:
  cmd.wait:
    - name: "grep -R \"my %config = (hive\" /usr/share/regripper/plugins | grep \"System\" | cut -f1 -d: | xargs -n1 -I{} basename {} | sed 's/.pl$//' > /usr/share/regripper/plugins/system"
    - watch:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-basepm:
  file.managed:
    - name: /usr/share/perl5/Parse/Win32Registry/Base.pm
    - source: /usr/local/src/regripper/Base.pm
    - mode: 755
    - require:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-filepm:
  file.managed:
    - name: /usr/share/perl5/Parse/Win32Registry/WinNT/File.pm
    - source: /usr/local/src/regripper/File.pm
    - mode: 755
    - require:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-keypm:
  file.managed:
    - name: /usr/share/perl5/Parse/Win32Registry/WinNT/Key.pm
    - source: /usr/local/src/regripper/Key.pm
    - mode: 755
    - require:
      - git: sift-scripts-regripper-git
