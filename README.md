# Managing SIFT with Saltstack

**WIP**: everything subject to change

## Install It

1. create a fresh ubuntu 16.04, if using vmware, use easy install and create a user `sansforensics`
2. install saltstack
3. download the latest signed release from the github releases page (see below for instructions)
  - Saltstack expects a certain folder structure, you'll need to have a root directory (eg- /tmp/salt)
  - You'll need to clone or extract the tarball to /tmp/salt/sift (yes it must be named sift)
4. `sudo salt-call --local --file-root=/tmp/salt` state.sls sift

## Installing Saltstack

Reference: http://repo.saltstack.com/#ubuntu

1. `wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -`
2. `echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" | sudo tee -s /etc/apt/sources.list.d/saltstack.list`
3. `sudo apt-get update`
4. `sudo apt-get install salt-minion`
5. `sudo service salt-minion stop` (Note: the SIFT install process will disable the minion altogether as we do not need it running as a service)

