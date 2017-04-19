include:
  - sift.repos.sift

python-dfvfs:
  pkg.installed:
    - name: python-dfvfs
    - version: 20160108-1ppa1~xenial
    - require:
      - pkgrepo: sift
    
    
