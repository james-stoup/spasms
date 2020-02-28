#!/bin/bash


# Simple check to ensure you are running this as root 
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi


# Modify this to suite your version of Fedora/CentOS/Whatever...
# dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/F-30-x86_64/pgdg-fedora-repo-latest.noarch.rpm

# install postgres
dnf install -y postgresql12.x86_64 postgresql12-devel.x86_64 postgresql12-libs.x86_64 postgresql12-server.x86_64
dnf install -y libpq-devel

# install some other misc tools
dnf install -y emacs
dnf install -y bash-completion
dnf install -y binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms



