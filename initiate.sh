
# On Performance testing VM
apt-get update
apt-get -y install build-essential zip unzip
wget http://phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_7.2.1_all.deb
dpkg -i phoronix-test-suite_7.2.1_all.deb

phoronix-test-suite benchmark c-ray
phoronix-test-suite benchmark fio

#Network testing on both east -> west + inside vpc testing
#iperf.he.net and inside VPC ip. port 5201
phoronix-test-suite benchmark iperf


# On iperf server vm
apt-get update
iperf -s &
