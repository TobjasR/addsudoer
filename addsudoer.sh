#!/bin/bash

if [ $# -ne 2 ]; then
	echo -e "usage: addsudoer.sh <user> [suffix]>\nuser's password will be '<rootpassword><suffix>'\nuse \"\" for empty suffix.";
	exit 3;
fi
echo "enter root password";
read -s rootpasswd;
echo "$rootpasswd" | ./chkpasswd.sh root -;
if (($?)); then 
	echo "unable to authenticate as root, password wrong or not enough privileges.";
	exit 1;
fi
pass="$rootpasswd$2";
useradd $1;
echo "$1:$pass" | chpasswd;
usermod -aG sudo $1;
echo -e "added sudoer:\n$1:$pass";
exit 0;
