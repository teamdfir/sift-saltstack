# Name: AWS CLI
# Website: https://docs.aws.amazon.com/cli/
# Description: Command Line Interface for interacting with AWS Cloud components
# Category: 
# Author: Amazon
# License: Apache License v2.0 (https://github.com/aws/aws-cli/blob/develop/LICENSE.txt)
# Version: 2.15.21
# Notes:

{% set hash = '77c6c3d1ac23638b07a02587ed6b1d4adc84c561c9ecc7df1ff3778e43a4b49b' %}

aws-cli-download:
  file.managed:
    - name: /tmp/awscli-exe-linux-x86_64.zip
    - source: https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

aws-cli-extract:
  archive.extracted:
    - name: /tmp/
    - source: /tmp/awscli-exe-linux-x86_64.zip
    - enforce_toplevel: False
    - overwrite: True
    - require:
      - file: aws-cli-download

aws-cli-install:
  cmd.run:
    - name: /tmp/aws/install -u
    - shell: /bin/bash
    - require:
      - file: aws-cli-download
      - archive: aws-cli-extract

aws-cli-cleanup:
  file.absent:
    - names:
      - /tmp/awscli-exe-linux-x86_64.zip
      - /tmp/aws/
    - require:
      - cmd: aws-cli-install
