#!/bin/bash

# On Performance testing VM
apt-get update
apt-get -y install build-essential zip unzip mysql-client iperf3 postgresql-client libxslt1.1 php-cli php-common php-xml php7.0-cli php7.0-common php7.0-json php7.0-opcache php7.0-readline php7.0-xml git sysbench
wget http://phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_7.2.1_all.deb
dpkg -i phoronix-test-suite_7.2.1_all.deb

# phoronix-test-suite benchmark c-ray
# phoronix-test-suite benchmark fio
#
# #Network testing on both east -> west + inside vpc testing
# #iperf.he.net and inside VPC ip. port 5201
# phoronix-test-suite benchmark iperf


# On iperf server vm
# apt-get update
# iperf3 -s &
