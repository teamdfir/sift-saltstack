include:
  - sift.repos.docker
  - sift.repos.gift
  - sift.repos.sift
  - sift.repos.openjdk
  - sift.repos.ubuntu-multiverse
  - sift.repos.ubuntu-universe
  - sift.repos.ubuntu-tweak


sift-repos:
  test.nop:
    - name: sift-repos
    - require:
      - sls: sift.repos.docker
      - sls: sift.repos.gift
      - sls: sift.repos.sift
      - sls: sift.repos.openjdk
      - sls: sift.repos.ubuntu-multiverse
      - sls: sift.repos.ubuntu-universe
      - sls: sift.repos.ubuntu-tweak
      
