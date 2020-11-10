#!/bin/bash

# docker
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
apt-key fingerprint 0EBFCD88

# llvm
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

# metasploit
wget -O - https://apt.metasploit.com/metasploit-framework.gpg.key | apt-key add -