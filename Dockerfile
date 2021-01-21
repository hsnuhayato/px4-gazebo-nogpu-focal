FROM px4io/px4-dev-simulation-focal

# Run a full upgrade and install utilities for development.
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tzdata
# timezone setting
ENV TZ=Asia/Tokyo

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    mesa-utils \
    xterm \
    build-essential gdb \
    cmake cmake-curses-gui \
    git \
    libgtest-dev \
    ssh \
    ipython3 \
    libgrpc++-dev \
 && rm -rf /var/lib/apt/lists/*


# install px4 toolchain
RUN wget https://raw.githubusercontent.com/PX4/Firmware/master/Tools/setup/ubuntu.sh && \
    wget https://raw.githubusercontent.com/PX4/Firmware/master/Tools/setup/requirements.txt && \
    bash ubuntu.sh && \
    pip3 install scipy && \
    pip3 install pyquaternion && \
    pip3 install mavsdk

RUN wget https://github.com/mavlink/MAVSDK/releases/download/v0.31.0/mavsdk_0.31.0_ubuntu20.04_amd64.deb && \
    sudo dpkg -i mavsdk_0.31.0_ubuntu20.04_amd64.deb

ENV QT_X11_NO_MITSHM 1
ENV XDG_RUNTIME_DIR /tmp/runtime-root