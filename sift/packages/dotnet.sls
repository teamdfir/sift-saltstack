include:
  - sift.repos.dotnet-backports

sift-package-dotnet9:
  pkg.installed:
    - name: dotnet-sdk-9.0
    - require:
      - sls: sift.repos.dotnet-backports
