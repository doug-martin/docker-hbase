#!/bin/bash

echo "============================="
echo " install defaults"
echo "============================="

apt-get update && \
	apt-get -y install python-software-properties curl dialog wget less procps telnet vim chkconfig	