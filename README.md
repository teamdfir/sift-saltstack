[![Build Status](https://travis-ci.org/sans-dfir/sift-saltstack.svg?branch=master)](https://travis-ci.org/sans-dfir/sift-saltstack)

# Managing SIFT with Saltstack

This is a **Work In Progress**. Organization and setup method might change. 

## Supported Distributions

* Ubuntu 16.04 (Xenial)

## Installation

1. create a fresh ubuntu 16.04, if using vmware, use easy install and create a user `sansforensics`
2. install saltstack
3. download the latest signed release from the github releases page (see below for instructions)
  - Saltstack expects a certain folder structure, you'll need to have a root directory (eg- /tmp/salt)
  - You'll need to clone or extract the tarball to /tmp/salt/sift (yes it must be named sift)
  - Example: `git clone https://github.com/sans-dfir/sift-saltstack /tmp/salt`
4. `sudo salt-call --local --file-root=/tmp/salt state.sls sift`

### Customizing the Install

You have full control over what you want to install from the SIFT distro. To really get a good understanding of what you can and cannot do I would encourage you to learn more about Saltstack. 

#### Installing only SIFT Packages

This is intended to replace Step 4 from above. This will install just the deb packages and python packages that makes up the SIFT distro, it will not create any users, change backgrounds, or any other customization of the linux install you are on.

```bash
sudo salt-call --local --file-root=/tmp/salt state.sls sift.repos,sift.packages,sift.python-packages
```

## Installing Saltstack

Reference: http://repo.saltstack.com/#ubuntu

1. `wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -`
2. `echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" | sudo tee /etc/apt/sources.list.d/saltstack.list`
3. `sudo apt-get update`
4. `sudo apt-get install salt-minion`
5. `sudo service salt-minion stop` (Note: the SIFT install process will disable the minion altogether as we do not need it running as a service)
