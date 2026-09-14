# Dependency only -- not in packages/init.sls. WeasyPrint dlopens pango at run time, so a
# pip install of it succeeds and then fails at import without these. Package names are the
# ones WeasyPrint documents for Ubuntu >= 20.04 installed from wheels:
# https://doc.courtbouillon.org/weasyprint/stable/first_steps.html
sift-package-libpango:
  pkg.installed:
    - name: libpango-1.0-0

sift-package-libpangoft2:
  pkg.installed:
    - name: libpangoft2-1.0-0
