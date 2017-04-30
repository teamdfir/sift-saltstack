include:
  - sift.repos.ubuntu-universal
  - sift.repos.ubuntu-tweak
  - sift.repos.docker
  - sift.repos.gift
  - sift.repos.sift
  - sift.repos.openjdk

sift-repos:
  test.nop:
    - name: sift-repos
    - require:
      - sls: sift.repos.ubuntu-universal
      - sls: sift.repos.ubuntu-tweak
      - sls: sift.repos.docker
      - sls: sift.repos.gift
      - sls: sift.repos.sift
      - sls: sift.repos.openjdk
      
