include:
  - sift.repos.docker

sift-package-docker:
  pkg.installed:
    - name: docker-ce
    - require:
      - pkgrepo: sift-docker-repo
      - sls: sift.repos.docker
