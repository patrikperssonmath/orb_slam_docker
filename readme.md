## Setup Instructions

1. initialize submodules

```console
git submodule update --init --recursive
```

2. install docker [docker](https://docs.docker.com/engine/install/)

3. install [nvidia container toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

4. download [EuRoc dataset](http://robotics.ethz.ch/~asl-datasets/ijrr_euroc_mav_dataset/machine_hall/MH_01_easy/MH_01_easy.zip)

unpack at /path/to/dataset_folder

5. build container

```console
./build_docker.sh
```

6. open container in terminal

```console
./run_docker.sh /path/to/dataset_folder
```

7. run orbslam example code

'''console
./Examples/Monocular-Inertial/mono_inertial_euroc ./Vocabulary/ORBvoc.txt ./Examples/Monocular-Inertial/EuRoC.yaml /data/MH_01_easy ./Examples/Monocular-Inertial/EuRoC_TimeStamps/MH01.txt
'''
