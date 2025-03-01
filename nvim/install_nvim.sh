#!/usr/bin/bash

#set -x # debug trace

echo "nvim setup started"
echo "+---------------------------------------------------------------------------------+"
echo "**WARNING**: Install these packages from Ubuntu repository"
echo "+---------------------------------------------------------------------------------+"
echo "sudo apt install make gcc xclip ripgrep tree-sitter-cli git unzip luarocks npm"

ORIG_CWD="${PWD}"
NVIM_APP_DIR="${HOME}/my_data/Apps/nvim"
NVIM_CONFIG_DIR="${HOME}/.config/nvim"
NVIM_EXEC_FILE="${NVIM_APP_DIR}/nvim.appimage"
NVIM_CONFIG_FILES_DIR="${HOME}/my_data/os_setup/nvim/config_files"
BASHRC="${HOME}/.bashrc"

mkdir -p ${NVIM_APP_DIR}

curl -s -o ${NVIM_EXEC_FILE} -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod +x ${NVIM_EXEC_FILE}
cd ${NVIM_APP_DIR}
${NVIM_EXEC_FILE} --appimage-extract
cd ${ORIG_CWD}
rm -f ${NVIM_APP_DIR}/nvim                                      # delete existing link, if any
ln -s ${NVIM_APP_DIR}/squashfs-root/AppRun ${NVIM_APP_DIR}/nvim # create new link

mkdir -p ${NVIM_CONFIG_DIR}
cp -ar ${NVIM_CONFIG_FILES_DIR}/* ${NVIM_CONFIG_DIR}

# shell aliases to invoke nvim
sed -i '/NVIM-START/,/NVIM-END/d' ${BASHRC}
cat <<DELIMITER >>${BASHRC}
###RK:NVIM-START
export PATH=\$PATH:${NVIM_APP_DIR}
alias nv="nvim"
alias vim="nvim"
alias vi="nvim"
set -o vi
###RK:NVIM-END
DELIMITER
echo "nvim setup done"

# echo "If there is issue with MarkdownPreview not opening a page in the browser
# for previewing markdown files, run this command in nvim command mode after all installation is completed:"
# echo ":call mkdp#util#install()"
