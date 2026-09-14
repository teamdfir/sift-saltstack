# Dependency only -- not in packages/init.sls. The other half of WeasyPrint's run-time
# text-shaping stack; see sift.packages.libpango.
sift-package-libharfbuzz:
  pkg.installed:
    - name: libharfbuzz0b

{% if grains['oscodename'] != 'jammy' %}
# jammy's harfbuzz (2.7.4) builds no subset package -- it first appears with harfbuzz 8.x
# on noble. An unguarded pkg.installed fails on jammy with "Unable to locate package".
# WeasyPrint lists it but does not need it: 69.0 renders a PDF on jammy without it,
# verified in the tester. Guarded rather than dropped so noble still matches upstream's
# documented set.
sift-package-libharfbuzz-subset:
  pkg.installed:
    - name: libharfbuzz-subset0
{% endif %}
