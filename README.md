koha.dev
======

Koha setup of development box

This Vagrant box is a vanilla debian Wheezy install of a Koha Development server.
It is intended to work as a basis for testing and creating patches on Koha master.
Setup of the vagrant box inspired by: 
https://mikegriffin.ie/blog/20130418-creating-a-debian-wheezy-base-box-for-vagrant/

## Includes

* Debian Wheezy 7 64bit
* koha-common 3.16.02
* Koha from git
  * (git clone --depth=1 https://github.com/Koha-Community/Koha.git)

It also contains a SaltStack provisioning to setup a minor development state

* git-bz      (git.koha-community.org/git-bz.git)
* koha-gitify (https://github.com/mkfifo/koha-gitify)

## Setup

`make` will setup the box for the first time. Takes some time as it loads a 
preinstalled Debian Wheezy image with koha instaled.

## Usage

Info on applying patches, etc. will come