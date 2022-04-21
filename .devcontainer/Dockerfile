FROM ubuntu:latest

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV DEBIAN_FRONTEND=noninteractive

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    tzdata \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# packages necessary for build
RUN apt-get update && apt-get install -y \
    build-essential \
    gdb \
    git \
    git-gui \
    cmake \
    nano \
    lsb-release \ 
    libeigen3-dev \
    libboost-all-dev \
    libtbb-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libatlas-base-dev \ 
    libsuitesparse-dev \
    libjpeg-dev \
    libpng-dev \
    libavcodec-dev \ 
    libavutil-dev \
    libavformat-dev \
    libswscale-dev \
    libavdevice-dev \
    libgl1-mesa-dev \
    libglew-dev \
    libpcap-dev \
    libssl-dev \
    libgtk2.0-dev \
    pkg-config\
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

COPY ./thirdparty /build_dep/thirdparty

RUN set -x && cd /build_dep && ./thirdparty/makedeps.sh --threads 6 &&  rm -r /build_dep

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/*

RUN echo "PATH='$PATH:/home/$USERNAME/.local/bin'" >> /home/$USERNAME/.bashrc

ENV DEBIAN_FRONTEND=dialog

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

VOLUME data

COPY ./ORB_SLAM3 /ORB_SLAM3
RUN set -x && cd /ORB_SLAM3 && ./build.sh