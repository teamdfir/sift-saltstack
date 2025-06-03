include:
  - sift.repos.sift
  - sift.repos.ubuntu-universe

sift-package-xmount:
  pkg.latest:
    - name: xmount
    - require:
      - sls: sift.repos.sift
      - sls: sift.repos.ubuntu-universe
    - onlyif:
      - fun: match.grain
        tgt: 'osarch:amd64'
