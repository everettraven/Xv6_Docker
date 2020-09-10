# About this Repository

This GitHub Repository was created as an easier way for students in the Florida Polytechnic University class COP4610 Operating Systems Concepts to run Xv6. This repository contains a Dockerfile that can be used to create a Docker image with QEMU and Xv6 installed. Upon running the image, you will instantly be loaded into an Xv6 instance in which can be used for testing and performing class assignments.

In order to use this resource you must have Docker installed and running.

# Installing Docker

For help installing Docker check out their documentation on proper installation. It can be found here: https://docs.docker.com/get-docker/ 

# Building the Docker Image

There are 2 different ways to build the Docker image:
    1. Build from source
    2. Pull the image from Docker Hub

## Build from source

The first step to building this image from source is to clone the repository. Start by running:
```
git clone https://github.com/everettraven/Xv6_Docker.git
```

Now change your working directory to the cloned repo directory and run the docker build command:

*NOTE: The docker build command can be run with the -t option to name the image a specific name. This is useful so that you don't forget what you have named the image. I recommend naming it 'xv6'.*

```
docker build .

OR

docker build -t xv6 .
```

## Pull the image from Docker Hub

In order for ease of use I have already pre-built the image and put it on my personal Docker Hub. It can be found at bpalmer/xv6. In order to pull the image down you can run:

```
docker pull bpalmer/xv6
```

# Usage

This resource uses GitHub Repositories to build Xv6 from source, but has an environment variable called `github_repo` that can be used to set which GitHub Repo to pull the Xv6 source from. By default it is set to pull from the official MIT Xv6 repo. This allows you to fork a version of the official MIT Xv6 Repo (2012 Version) and make changes. If you change the environment variable to point to your forked version it will build and run Xv6 based off of that and include any changes that you have made to the base Xv6 build.

The official MIT Xv6 (2012 Version) GitHub Repository can be found here: https://github.com/mit-pdos/xv6-public

**UPDATE**: I have now made it possible to use the files that Dr. Jaimes has provided in the course modules. You will have to download the tar file and extract all the files from it. You will still need to create a GitHub Repository to use for this. You will also need to change line #56 in the Makefile to:
```
QEMU := "/usr/bin/qemu-system-i386"
```

## Run the Docker Container with default setting for environment variable

```
docker run -it <image>
```

## Run the Docker Container with the environment variable pointing to a new GitHub Repository

```
docker run -e github_repo=<GITHUB_LINK_HERE> -it <image>
```

*NOTE: Replace values surrounded with <> with the actual values*

## Exiting Xv6

By default, Xv6 does not have an exit command. You will need to exit the QEMU instance by using a specific set of commands.

First you must press and release CTRL + A to signal to QEMU that you are giving it a command. Once that is done you must press X and QEMU will close the instance which will in turn end the running Docker container.

*NOTE: This command was given for standard keyboard layout that has the CTRL key. If you are using a Mac adjust accordingly. The correct key for Mac should be Control*

# Cleaning up Docker Containers
If you want to clean up unused Docker Containers since you'll be spinning up a new container every time you issue a `docker run` command here are some actions you can take to do so:

## --rm flag on docker run

The `--rm` flag when using the `docker run` command will make it so that the container is removed from your system the moment it finishes running

## Remove all Docker Containers run from a specific Docker Image

This can be done using PowerShell in Windows by running the following command (replacing <IMAGE_NAME_HERE> with the image name)

```
docker container ls -a --format='{{json .}}' | ConvertFrom-JSON | Where-Object {$_.Image -eq "<IMAGE_NAME_HERE>"} | ForEach-Object {docker container rm $_.ID}
```

*NOTE: Currently there is only a solution for Windows systems for a batch delete. Currently working on one for Unix based systems.*

## Remove Docker Containers one by one

You can remove a Docker Container by running:

```
docker container rm <CONTAINER_ID>
```

## Prune Docker Containers

**WARNING:** **RUNNING THIS COMMAND WILL DELETE ALL STOPPED CONTAINERS ON YOUR COMPUTER**

In order to delete all stopped containers on your computer you can run:

```
docker container prune
```
