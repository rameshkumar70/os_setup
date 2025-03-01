#!/usr/bin/bash

echo "### Ensure tmux & git are installed first!"
echo "sudo apt install tmux git"
# sudo apt install tmux git

# Install tmux plugin manager
rm -rf ${HOME}/.tmux     # remove current installation of plugin manager
rm -f ${HOME}/.tmux.conf # remove current ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm

# copy our config template to actual filepath for tmux to read
# Tmux config file is ~/.tmux.conf
cp ./config_files/tmux.conf ${HOME}/.tmux.conf

BASHRC="${HOME}/.bashrc"

# shell aliases to invoke tmux command
sed -i '/SED-START/,/SED-END/d' ${BASHRC}
cat <<'DELIMITER' >>${BASHRC}
###RK:SED-START
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'
alias tks='tmux kill-session -t'
###RK:SED-END
DELIMITER

echo "tmux setup done"
