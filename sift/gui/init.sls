include:
  - sift.gui.terminal
  - sift.gui.theme
  - sift.gui.unity

sift-gui:
  test.nop:
    - name: sift-gui
    - require:
      - sls: sift.gui.terminal
      - sls: sift.gui.theme
      - sls: sift.gui.unity
