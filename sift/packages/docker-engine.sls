include:
  - ..repos.docker

docker-engine:
  pkg.installed:
    - require:
      - pkgrepo: docker
