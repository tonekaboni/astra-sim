//////// running chakra:    !! run before astra-sim in a different virtual environment and not in the same environment as astra-sim

cd extern/graph_frontend/chakra

// Create a virtual environment
python3 -m venv chakra_env

// Activate the virtual environment
source chakra_env/bin/activate

pip install .

pip install --upgrade protobuf

//for generator: 
python -m chakra.et_generator.et_generator --num_npus <num_npus> --num_dims <num_dims>


//////// building astra-sim with ns3: 

git clone --recurse-submodules git@github.com:tonekaboni/astra-sim.git

cd astra-sim

// only once
docker build -t astra-sim .

docker run -it astra-sim

apt update && apt install openmpi-bin libopenmpi-dev

chmod +x ./build/astra_ns3/build.sh

// to compile:
./build/astra_ns3/build.sh -c

// to run astra sim: 
./build/astra_ns3/build.sh -r

