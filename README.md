# sift-saltstack

Bootstraping SIFT using Saltstack

**WIP**: everything subject to change

1. create a fresh ubuntu 16.04, if using vmware, use easy install and create a user `sansforensics`
2. clone this repo into /srv as root
  * `git clone https://github.com/sans-dfir/sift-saltstack.git /srv`
3. `sudo bash /srv/bootstrap.sh`
4. `sudo salt-call --local state.apply`

All the magic happens in step 4, it'll take a little bit to run. You can run it as many times as you would like, if there is nothing to update or change, the output will indicate as much.
