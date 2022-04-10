# cuQuantum SDK docker image
Docker image that provides nVidia's cuQuantum running environment with Python 3.

**This image only run on nVidia supported docker**

## Prerequisite
- Docker with nVidia GPU support
  - [nVidia's container toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/overview.html)
  - [Docker Desktop WSL2 backend](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/overview.html)
- nVidia driver (>= 470) on host machine

## Usage
```
docker run -it --rm --gpus all sanori/cuquantum-py
```
Note that the `--gpus all` option.

You can import `cuquantum` package in python.

When you try to run sample programs on https://github.com/NVIDIA/cuQuantum ,
1. Clone the repo.
2. Run the following command
    ```
    docker run -it --rm --gpus all -v $PWD/cuQuantum:/home/user/cuQuantum sanori/cuquantum-py
    ```
3. Navigate the directories and run some programs.

## Test if nVidia GPUs are connected
```
docker run -it --rm --gpus all sanori/cuquantum-py nvidia-smi
```