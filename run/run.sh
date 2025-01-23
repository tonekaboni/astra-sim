#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath $0)")

# generating workload:

cd "${SCRIPT_DIR}/../extern/graph_frontend/chakra"
python3 -m venv chakra_env

source "chakra_env/bin/activate"

pip install .
pip install protobuf==5.29.0
cd ./src/generator
chakra_generator --num_npus 8
deactivate
mv ./mixed_flex* ../../../../../run/workload/
cd "${SCRIPT_DIR}/.."

#compile and run astrasim:

./build/astra_ns3/build.sh -c
timeout 5s ./build/astra_ns3/build.sh -r

#visualize:

cd "${SCRIPT_DIR}/../extern/network_backend/ns-3/scratch/output"

python3 qlen-visualiser.py

mv ./sw_Q_size_graph.png ../../../../../run/output/
mv ./qlen.txt ../../../../../run/output/
mv ./linkUtil.txt ../../../../../run/output/
