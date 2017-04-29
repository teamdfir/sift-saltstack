include:
  - ..repos.sift
  - .git

python-volatility:
  pkg.installed:
    - name: python-volatility
    - require:
      - pkgrepo: sift

python-volatility-community-plugins:
  git.latest:
    - name: https://github.com/volatilityfoundation/community.git
    - target: /usr/lib/python2.7/dist-packages/volatility/contrib
    - user: root
    - rev: 29b07e7223f55e3256e3faee7b712030676ecdec
    - require:
      - pkg: git
      - pkg: python-volatility
