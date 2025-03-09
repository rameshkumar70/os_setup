export INSTALL_DIR="${HOME}/.local/share/python"
echo "## Note: This installs Python in your ${INSTALL_DIR} directory. You can modify the PATH if needed for a different installation location."

# Install Python3 and Libraries as a local user.
python_config() {
    BASHRC="${HOME}/.bashrc"
    export PYTHON_VER="3.12.4"
    export PYTHON_VER_SHORT="$(echo ${PYTHON_VER} | cut -d '.' -f1,2)"
    export PYTHON_REQ="/tmp/requirements.txt"
    cd ${HOME}
    rm -rf ${INSTALL_DIR} && mkdir -p ${INSTALL_DIR}

    sed -i '/PYTHON-START/,/PYTHON-END/d' ${BASHRC}
    cat <<DELIMITER >>${BASHRC}
###RK:PYTHON-START
alias python='python3'
export PATH=${INSTALL_DIR}/bin:\${PATH}
##RK:PYTHON-END
DELIMITER
    source ${BASHRC}
    wget --quiet --no-check-certificate "https://www.python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tgz"
    tar -zxvf ${HOME}/Python-${PYTHON_VER}.tgz 1>/dev/null
    cd ${HOME}/Python-${PYTHON_VER}/
    echo "Python ${PYTHON_VER} - Installing in current logged-in user - $(whoami)"
    echo "Python ${PYTHON_VER} - Installation in-progress. Please wait..."
    ./configure --enable-optimizations --prefix=${INSTALL_DIR} >/dev/null 2>&1
    echo "Python ${PYTHON_VER} - ETA: upto 5mins. Please wait..."
    make altinstall >/dev/null 2>&1
    ln -s ${INSTALL_DIR}/bin/python${PYTHON_VER_SHORT} ${INSTALL_DIR}/bin/python3
    ln -s ${INSTALL_DIR}/bin/pip${PYTHON_VER_SHORT} ${INSTALL_DIR}/bin/pip3

    # Install PIP3
    wget --quiet --no-check-certificate https://bootstrap.pypa.io/get-pip.py -O - | python3 - --prefix=${INSTALL_DIR}
    source ${BASHRC}
    ${INSTALL_DIR}/bin/pip3 install --upgrade pip
    ${INSTALL_DIR}/bin/pip3 install --upgrade --no-cache-dir -r ${PYTHON_REQ} --use-pep517
    cd ${HOME} && rm -rf ${HOME}/Python-${PYTHON_VER}*

    ${INSTALL_DIR}/bin/python3 --version
    ${INSTALL_DIR}/bin/pip3 --version
    echo "Python ${PYTHON_VER} - Setup Completed!"
}

# Function Call
python_config
