sudo dpkg --add-architecture i386

sudo apt update
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/oracular/winehq-oracular.sources
sudo apt update

sudo apt install --install-recommends winehq-stable
wine --version



to update wine:
sudo apt-get upgrade winehq-stable


to remove wine:
sudo apt remove wine


