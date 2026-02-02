# Name: Docker
# Website: https://www.docker.com
# Description: Run and manage containers.
# Category: 
# Author: Docker Inc.
# License: Apache License 2.0: https://github.com/moby/moby/blob/master/LICENSE
# Notes: 

include:
  - sift.repos.docker

sift-package-docker:
  pkg.installed:
    - name: docker-ce
    - require:
      - file: sift-docker-repo
      - sls: sift.repos.docker
