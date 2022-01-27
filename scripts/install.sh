##
## Install base tools
##

echo '[INFO] Initializing environment...'
. ./.env

echo '[INFO] Installing build essentials...'
sudo apt-get install build-essential --yes

echo '[INFO] Installing go v1.17.2...'
wget -q -O - https://git.io/vQhTU | bash -s -- --version 1.17.2

##
## Preparing tmp directory
##
mkdir ./tmp
cd ./tmp

##
## Install IBC enabled binaries
##

echo '[INFO] Installing Osmosis binary...'
rm -rf osmosis
git clone https://github.com/osmosis-labs/osmosis
cd osmosis
git checkout v6.0.0
make install
cd ..

echo '[INFO] Installing Lum Network binary...'
rm -rf lum
git clone https://github.com/lum-network/chain.git lum
cd lum
git checkout v1.0.5
go mod tidy
make install
cd ..

echo '[INFO] Installing Ki binary...'
rm -rf ki-tools
git clone https://github.com/KiFoundation/ki-tools.git
cd ki-tools
git checkout -b v2.0.1 tags/2.0.1
make install
cd ..

echo '[INFO] Installing Gaiad binary...'
rm -rf gaia
git clone https://github.com/cosmos/gaia
cd gaia
git checkout v5.0.2
make install
cd ..

echo '[INFO] Installing Chain-maind binary...'
rm -rf chain-main
git clone https://github.com/crypto-org-chain/chain-main
cd chain-main
git checkout v3.3.3
make install
cd ..

##
## Install go relayer
##

echo '[INFO] Installing Go Relayer...'
git clone https://github.com/lum-network/relayer.git
cd relayer
git checkout main
make install
cd ..

##
## Leaving tmp directory
##
cd ..

##
## Installing chain daemons
##

echo '[INFO] Installing networks daemons...'
sudo cp ./daemons/* /etc/systemd/system/.
sudo systemctl daemon-reload
sudo systemctl enable osmosisd
sudo systemctl enable lumd
sudo systemctl enable kid
sudo systemctl enable gaiad
sudo systemctl enable crypto
