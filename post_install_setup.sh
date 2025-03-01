#!/usr/bin/bash

# set -x # uncomment for trace debugging

# install nvim
echo "+-------------------------------+"
echo " Installing Nvim"
echo "+-------------------------------+"
./nvim/install_nvim.sh

# install nvim
echo "+-------------------------------+"
echo " Configuring Tmux"
echo "+-------------------------------+"
./tmux/setup_tmux.sh

# install xournal++
echo "+-------------------------------+"
echo " Installing Xournal"
echo "+-------------------------------+"
# sudo apt install xournalpp

echo "Install the following packages:"
echo "- Chrome Browser (from Google website)"
echo "- Spotify"

echo "set PATH for ~/my_data/bin/scripts"
