![Logo](https://images.contentstack.io/v3/assets/blt36c2e63521272fdc/blt3e371eacc79a3ca4/60a5393fe2db156d00f0b8ab/400x460_DFIR_SIFT.jpg)

# Managing SIFT with Saltstack

## Issues

Please open issues over at the [SIFT Repository](https://github.com/sans-dfir/sift/issues/new?title=[SALTSTACK]%20-) with prefix '[SALTSTACK]'

## Supported Distributions

* Ubuntu 18.04 (Bionic) (DEPRECATED)
* Ubuntu 20.04 (Focal)

## Installation

### Preferred

Use the [sift-cli](https://github.com/sans-dfir/sift-cli) tool.

### Alternate (Manual)

#### 20.04

**Status:** Stable

There are two primary modes, `desktop` and `server` in step 4 the example shows desktop, simply swap that word out for server if you want to see the server mode.

1. Ubuntu 20.04
2. Install SaltStack for 20.04 (Focal) (See 20.04 instructions below)
3. `sudo git clone https://github.com/teamdfir/sift-saltstack.git /srv/salt`
4. `sudo salt-call --local state.sls sift.desktop pillar='{"sift_version": "dev", "sift_user": "REPLACE_WITH_YOUR_USERNAME"}'`

**Important:** Make sure you replace the `REPLACE_WITH_YOUR_USERNAME` with your actual username that you are running.

**Desktop Note:** If you are installing desktop mode, please make sure you run all the commands from a terminal within the Desktop environment.

#### 18.04

**Status:** Stable

There are two primary modes, `desktop` and `server` in step 4 the example shows desktop, simply swap that word out for server if you want to see the server mode.

1. Ubuntu 18.04
2. Install SaltStack for 18.04 (Bionic) (See 18.04 instructions below)
3. `sudo git clone https://github.com/teamdfir/sift-saltstack.git /srv/salt`
4. `sudo salt-call --local state.sls sift.desktop pillar='{"sift_version": "dev", "sift_user": "REPLACE_WITH_YOUR_USERNAME"}'`

**Important:** Make sure you replace the `REPLACE_WITH_YOUR_USERNAME` with your actual username that you are running.

**Desktop Note:** If you are installing desktop mode, please make sure you run all the commands from a terminal within the Desktop environment.

#### 16.04

**No Longer Supported**

### Customizing the Install

You have full control over what you want to install from the SIFT distro. To really get a good understanding of what you can and cannot do I would encourage you to learn more about Saltstack. 

#### Installing only SIFT Packages

This is intended to replace Step 4 from above. This will install just the deb packages and python packages that makes up the SIFT distro, it will not create any users, change backgrounds, or any other customization of the linux install you are on.

```bash
sudo salt-call -l info --local --file-root=/tmp/salt state.apply sift.pkgs
```

## Installing Saltstack

### 20.04

1. `wget -O - https://repo.saltstack.com/apt/ubuntu/20.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -`
2. `echo "deb http://repo.saltstack.com/apt/ubuntu/20.04/amd64/latest focal main" | sudo tee /etc/apt/sources.list.d/saltstack.list`
3. `sudo apt-get update`
4. `sudo apt-get install salt-minion`
5. `sudo service salt-minion stop`

Note: the SIFT install process will disable the minion altogether as we do not need it running as a service

### 18.04

1. `wget -O - https://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -`
2. `echo "deb http://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest bionic main" | sudo tee /etc/apt/sources.list.d/saltstack.list`
3. `sudo apt-get update`
4. `sudo apt-get install salt-minion`
5. `sudo service salt-minion stop`

Note: the SIFT install process will disable the minion altogether as we do not need it running as a service

### 16.04

**No Longer Supported**
