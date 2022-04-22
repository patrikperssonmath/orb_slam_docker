## Setup Instructions

initialize submodules

'git submodule update --init --recursive'

install docker:

[docker doc](https://docs.docker.com/engine/install/)

install nividia container toolkit

[nvidia toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

download dataset

[EuRoc](http://robotics.ethz.ch/~asl-datasets/ijrr_euroc_mav_dataset/machine_hall/MH_01_easy/MH_01_easy.zip)

unpack at /path/to/dataset_folder

build container

'
./build_docker.sh
'

open container in terminal

'
./run_docker.sh /path/to/dataset_folder
'

run orbslam example code

./Examples/Monocular-Inertial/mono_inertial_euroc ./Vocabulary/ORBvoc.txt ./Examples/Monocular-Inertial/EuRoC.yaml /data/MH_01_easy ./Examples/Monocular-Inertial/EuRoC_TimeStamps/MH01.txt
