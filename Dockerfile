FROM ubuntu:16.04

RUN \
  apt-get update && \
  apt-get install -y wget && \
  wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add - && \
  echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" | tee /etc/apt/sources.list.d/saltstack.list && \
  apt-get update && \
  apt-get install -y salt-minion

