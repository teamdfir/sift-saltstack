sift-scripts-screen-scale:
  file.managed:
    - name: /usr/local/bin/set-display-scale
    - user: root
    - group: root
    - mode: 755
    - contents: |
        #!/bin/bash

        SCALE=$1
        DISPLAYNAME=$( xrandr | grep "connected primary" | awk '{print $1}' )

        if [[ $SCALE =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]; then 
            xrandr --output $DISPLAYNAME --scale ${SCALE}x${SCALE}
        else
            echo "please supply a valid scale.  <1 makes everything bigger, >1 makes everything smaller."
        fi
