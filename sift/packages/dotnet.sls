include:
  - sift.repos.dotnet-backports

sift-package-dotnet9:
  pkg.installed:
    - name: dotnet-sdk-9.0
    - require:
      - sls: sift.repos.dotnet-backports

# Eric Zimmerman's tools target net10.0 (sift.scripts.zimmerman).
sift-package-dotnet10-runtime:
  pkg.installed:
    - name: dotnet-runtime-10.0
    - require:
      - sls: sift.repos.dotnet-backports
