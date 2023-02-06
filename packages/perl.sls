sift-package-perl:
  pkg.installed:
    - name: perl

sift-package-perl-cpan-configure:
  cmd.wait:
    - name: perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit'
    - watch:
      - pkg: sift-package-perl

sift-package-cpanminus:
  pkg.installed:
    - name: cpanminus
    - require:
      - pkg: sift-package-perl