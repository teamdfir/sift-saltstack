<img align="right" src="https://images.contentstack.io/v3/assets/blt36c2e63521272fdc/blt3e371eacc79a3ca4/60a5393fe2db156d00f0b8ab/400x460_DFIR_SIFT.jpg"/>

# SIFT

![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/teamdfir/sift-saltstack/total)

Built with [SaltStack](https://saltproject.io) installed with [Cast](https://github.com/ekristen/cast)

## Issues

Please open issues over at the [SIFT Repository](https://github.com/sans-dfir/sift/issues/new?title=[SALTSTACK]%20-) with prefix '[SALTSTACK]'

## Supported Distributions

* Ubuntu 20.04 (Focal) (deprecated)
* Ubuntu 22.04 (Jammy)

## Installation

Use [cast](https://github.com/ekristen/cast), it has replaced the [sift-cli](https://github.com/sans-dfir/sift-cli) tool.

You must install cast on your system, then it's as simple as run the following command ...

```console
sudo cast install teamdfir/sift-saltstack
```

**Note:** If you want server only mode throw `--mode=server` on the command.

### About Cast

Cast is the successor to the SIFT CLI. It is designed to be a distro agnostic installation tool. It leverages saltstack still under the hood to do the installation but makes it possible to build more distros quicker and easier. It supports SIFT and REMnux out of the box. Cast comes with a set of publishing tools as well to make releasing newer versions of distros easier.

Cast is a single binary written in golang instead of node.js that is cross platform compatible, this means eventually it can install distributions on Windows or ARM64 systems as well.

Finally, Cast leverages a the single binary method of install on linux for SaltStack, this means no left over salt subsystem on the host.
