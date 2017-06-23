include:
  - ..repos.docker

docker-engine:
  pkg.installed:
    - require:
      - pkgrepo: sift-docker-repo
