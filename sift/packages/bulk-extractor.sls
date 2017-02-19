include:
  - ..repos.sift
  - ..repos.openjdk

bulk-extractor:
  pkg.installed:
    - require:
      - pkgrepo: sift 
      - pkgrepo: openjdk-repo
