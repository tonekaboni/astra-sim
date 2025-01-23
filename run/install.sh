#!/bin/bash
set -e

# find the absolute path to this script
SCRIPT_DIR=$(dirname "$(realpath "$0")")
PROJECT_DIR="${SCRIPT_DIR:?}/.."
CHAKRA_DIR="${PROJECT_DIR:?}/extern/graph_frontend/chakra"
PARAM_DIR="${PROJECT_DIR:?}/extern/graph_frontend/param"

# start
echo "[ASTRA-sim] Installing Chakra Package..."

# install param: Chakra dependency (required for real system trace conversion)
echo "[ASTRA-sim] Installing param/et_replay..."
echo ""
cd "${PROJECT_DIR:?}"/extern/graph_frontend/chakra
git clone https://github.com/facebookresearch/param.git
cd param/et_replay
git checkout 7b19f586dd8b267333114992833a0d7e0d601630
pip3 install .



# install Chakra
echo ""
echo "[ASTRA-sim] Installing Chakra..."
echo ""
pip3 install "${CHAKRA_DIR:?}"

# done
echo ""
echo "[ASTRA-sim] Chakra installation finished."


echo "[ASTRA-sim] ASTRA-sim installation started."


cd "${PROJECT_DIR:?}"
sudo apt -y update
sudo apt -y install coreutils wget vim git
sudo apt -y install gcc-11 g++-11 make cmake 
sudo apt -y install clang-format 
sudo apt -y install libboost-dev libboost-program-options-dev
sudo apt -y install python3.10 python3-pip
sudo apt -y install libprotobuf-dev protobuf-compiler
sudo apt -y install openmpi-bin openmpi-doc libopenmpi-dev

pip3 install --upgrade pip
pip3 install protobuf==5.28.2
pip3 install graphviz pydot

chmod +x ./build/astra_ns3/build.sh
./build/astra_ns3/build.sh -c

chmod +x ./run/run.sh
