FROM amd64/ubuntu:latest

# This line prevents the Docker build process from halting and prompting due to setting tzdata
ARG DEBIAN_FRONTEND=noninteractive 

# This ENV variable will be used to pull the proper GitHub repo for running Xv6.
# This will default to the MIT Xv6 repo (2012 version)
ENV github_repo="https://github.com/mit-pdos/xv6-public.git"

# Install all necessary dependencies for running Xv6
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y git
RUN apt-get install -y gcc
RUN apt-get install -y make
RUN apt-get install -y qemu-system

# Clone the Xv6 (not RISC-V one) Github Repo
# RUN git clone https://github.com/mit-pdos/xv6-public.git
# WORKDIR ./xv6-public
# RUN make

CMD git clone ${github_repo} xv6 && cd xv6 && make && make qemu-nox

