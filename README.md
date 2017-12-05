[![Logo](https://digital-forensics.sans.org/images/sift.png)

[![Build Status](https://travis-ci.org/sans-dfir/sift-saltstack.svg?branch=master)](https://travis-ci.org/sans-dfir/sift-saltstack)

# Managing SIFT with Saltstack

## Issues 

Please open issues over at the [SIFT Repository](https://github.com/sans-dfir/sift/issues/new?title=[SALTSTACK]%20-) with prefix '[SALTSTACK]'

## Supported Distributions

* Ubuntu 16.04 (Xenial)

## Installation

### Preferred

Use the [sift-cli](https://github.com/sans-dfir/sift-cli) tool.

### Alternate (Manual)

It is hightly recommended that you use the [sift-cli](https://github.com/sans-dfir/sift-cli) tool to install, update and upgrade SIFT.

1. Ubuntu 16.04 Machine
2. Install Saltstack (see below)
3. Import the PGP Key - gpg --keyserver pgp.mit.edu --recv-keys 22598A94
4. Download the latest signed [releases](https://github.com/sans-dfir/sift-saltstack/releases/latest) files
5. Verify the latest signed release files with GPG
6. Extract the `.tar.gz` file to `/tmp/salt` (make sure this README.md is in the root of /tmp/salt)
7. `sudo salt-call -l info --local --file-root=/tmp/salt state.apply sift.vm`

### Customizing the Install

You have full control over what you want to install from the SIFT distro. To really get a good understanding of what you can and cannot do I would encourage you to learn more about Saltstack. 

#### Installing only SIFT Packages

This is intended to replace Step 4 from above. This will install just the deb packages and python packages that makes up the SIFT distro, it will not create any users, change backgrounds, or any other customization of the linux install you are on.

```bash
sudo salt-call -l info --local --file-root=/tmp/salt state.apply sift.pkgs
```

## Installing Saltstack

Reference: http://repo.saltstack.com/#ubuntu

1. `wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -`
2. `echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" | sudo tee /etc/apt/sources.list.d/saltstack.list`
3. `sudo apt-get update`
4. `sudo apt-get install salt-minion`
5. `sudo service salt-minion stop` (Note: the SIFT install process will disable the minion altogether as we do not need it running as a service)
