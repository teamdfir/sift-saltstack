# Name: AWS CLI
# Website: https://docs.aws.amazon.com/cli/
# Description: Command Line Interface for interacting with AWS Cloud components
# Category: 
# Author: Amazon
# License: Apache License v2.0 (https://github.com/aws/aws-cli/blob/develop/LICENSE.txt)
# Version: 2.15.24
# Notes:

{% set hash = 'c939005170508b19f53730ead3e15b959ec2d9d078a44668e43275864d73ef2f' %}
{% set version = '2.15.24' %}

aws-cli-download:
  file.managed:
    - name: /tmp/awscli-exe-linux-x86_64-{{ version }}.zip
    - source: https://awscli.amazonaws.com/awscli-exe-linux-x86_64-{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

aws-cli-extract:
  archive.extracted:
    - name: /tmp/
    - source: /tmp/awscli-exe-linux-x86_64-{{ version }}.zip
    - enforce_toplevel: False
    - overwrite: True
    - trim_output: True
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
      - /tmp/awscli-exe-linux-x86_64-{{ version }}.zip
      - /tmp/aws/
    - require:
      - cmd: aws-cli-install
