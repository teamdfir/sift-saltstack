include:
  - sift.repos.noobslab

sift-package-arc-icons:
  pkg.installed:
    - name: arc-icons
    - require:
      - pkgrepo: sift-repo-noobslab-icons
