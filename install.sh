##
## Install base tools
##

echo 'Initializing environment...'
. ibc-testbed/.env

echo 'Installing build essentials...'
sudo apt-get install build-essential --yes

echo 'Installing go v1.17.2...'
wget -q -O - https://git.io/vQhTU | bash -s -- --version 1.17.2

##
## Install IBC enabled binaries
##
echo 'Installing Osmosis binary...'
git clone https://github.com/osmosis-labs/osmosis
cd osmosis
git checkout v6.0.0
make install
cd ..

echo 'Installing Lum Network binary...'
git clone https://github.com/lum-network/chain.git lum
cd lum
git checkout v1.0.5
go mod tidy
make install
cd ..

echo 'Installing Ki binary...'
git clone https://github.com/KiFoundation/ki-tools.git
cd ki-tools
git checkout -b v2.0.1 tags/2.0.1
make install
cd ..

echo 'Installing Gaiad binary...'
git clone https://github.com/cosmos/gaia
cd gaia
git checkout v5.0.2
make install
cd ..

##
## Installing chain daemons
##

sudo cp ./ibc-testbed/daemons/* /etc/systemd/system/.
sudo systemctl daemon-reload
sudo systemctl enable osmosisd
sudo systemctl enable lumd
sudo systemctl enable kid
sudo systemctl enable gaiad
sudo systemctl enable rly-lum-osmosis
sudo systemctl enable rly-ki-osmosis
sudo systemctl enable rly-cosmos-osmosis

##
## Install go relayer
##

git clone https://github.com/cosmos/relayer.git
cd relayer
git checkout v1.0.0
make install
cd ..
