# Name: liblightgrep
# Warning: Only Supported on amd64 architecture

include:
  - sift.repos.sift

liblightgrep:
  pkg.installed:
    - name: liblightgrep
    - require:
      - sls: sift.repos.sift
    - onlyif:
      - fun: match.grain
        tgt: 'osarch:amd64'
