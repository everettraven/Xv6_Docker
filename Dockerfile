# Use Alpine to bring the image size WAY down
FROM alpine:latest

LABEL maintainer="everettraven@gmail.com"

ENV github_repo="https://github.com/mit-pdos/xv6-public.git"

# Use --no-cache when adding necessary packages to keep image size down
RUN apk add --no-cache \
    gcc \
    git \
    libc-dev \
    make \
    perl \
    qemu-system-i386

# Run Xv6
CMD git clone ${github_repo} xv6 && cd xv6 && make qemu-nox

