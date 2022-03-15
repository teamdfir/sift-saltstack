#FROM ubuntu:16.04
FROM ubuntu:20.04

RUN \
  apt-get update && \
  apt-get install -y wget gnupg && \
  wget -O - https://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add - && \
  echo "deb http://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest bionic main" | tee /etc/apt/sources.list.d/saltstack.list && \
  apt-get update && \
  apt-get install -y salt-minion

