#1/usr/bin/env bash

grep -q '^export PLP_CONNECT_PATH=' ~/.bashrc && \
sed -i "s|^export PLP_CONNECT_PATH=.*|export PLP_CONNECT_PATH="$1"|" ~/.bashrc || \
echo "export PLP_CONNECT_PATH=$1" >> ~/.bashrc

source $HOME/.bashrc