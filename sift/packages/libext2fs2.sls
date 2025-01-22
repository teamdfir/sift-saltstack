# Name: libext2fs2 (e2fsprogs)
# Website: https://e2fsprogs.sourceforge.net/
# Description: File system utilities for use with the ext2 file system
# Category:
# Author: Theodore Ts'o (https://thunk.org/tytso/)
# License: GNU General Public License v2 and GNU Library General Public License v2 (https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/tree/NOTICE)
# Notes:

{% if grains['oscodename'] == 'jammy' %}
  {% set package = 'libext2fs2' %}
{% elif grains['oscodename'] == 'noble' %}
  {% set package = 'libext2fs2t64' %}
{% endif %}

sift-package-libext2fs2:
  pkg.installed:
    - name: {{ package }}

