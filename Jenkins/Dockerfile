# =============================================================================
#  @@-COPYRIGHT-START-@@
#  
#  Copyright (c) 2020, Qualcomm Innovation Center, Inc. All rights reserved.
#  
#  Redistribution and use in source and binary forms, with or without 
#  modification, are permitted provided that the following conditions are met:
#  
#  1. Redistributions of source code must retain the above copyright notice, 
#     this list of conditions and the following disclaimer.
#  
#  2. Redistributions in binary form must reproduce the above copyright notice, 
#     this list of conditions and the following disclaimer in the documentation 
#     and/or other materials provided with the distribution.
#  
#  3. Neither the name of the copyright holder nor the names of its contributors 
#     may be used to endorse or promote products derived from this software 
#     without specific prior written permission.
#  
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
#  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
#  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
#  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
#  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
#  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
#  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
#  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
#  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#  POSSIBILITY OF SUCH DAMAGE.
#  
#  SPDX-License-Identifier: BSD-3-Clause
#  
#  @@-COPYRIGHT-END-@@
# =============================================================================

# Docker image file to build and test AIMET in a GPU environment

FROM tensorflow/tensorflow:1.15.0-gpu-py3-jupyter

ENTRYPOINT ["/bin/bash"]

RUN apt-get update > /dev/null && \
    apt-get install --no-install-recommends -y \
        # Bare minimum Packages
        ca-certificates \
        git \
        ssh \
        sudo \
        wget \
        xterm \
        xauth > /dev/null && \
        rm -rf /var/lib/apt/lists/*

# Install certificates
RUN sudo update-ca-certificates

# Modified version of bash.bashrc that adjusts the prompt
### COPY bash.bashrc /etc/
### RUN chmod 644 /etc/bash.bashrc

### COPY profile.global /usr/local/etc/
### RUN chmod 555 /usr/local/etc/profile.global

# Add sudo support
RUN echo "%users ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN apt-get update > /dev/null && \
    apt-get install --no-install-recommends -y \

        # Python
        python \
        python3-dev \
        python3-pip \

        # Nvidia cuda profiler
        libcupti-dev \

        # lmdb depenedency
        libffi-dev && \
        rm -rf /var/lib/apt/lists/*

# Python 2 pip installation
RUN apt-get update && apt-get install -y python-pip && rm -rf /var/lib/apt/lists/* && \
    python2.7 -m pip --no-cache-dir install --upgrade \
        pip==20.3.4 \
        restkit==4.2.2

# Upgrade Python3 pip and install some more packages
RUN pip3 --no-cache-dir install --upgrade \
        setuptools==41.0.1 \
        pip==20.2.4 \
        numpy==1.16.4 \
        wheel==0.33.4

# nvidia-docker hooks
LABEL com.nvidia.volumes.needed="nvidia_driver"

# Update all paths
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64/:/usr/local/cuda-10.0/extras/CUPTI/lib64:$LD_LIBRARY_PATH
ENV CUDA_TOOLKIT_PATH=/usr/local/cuda
ENV CUDNN_INSTALL_PATH=/usr/local/cuda
ENV CUDA_HOME=/usr/local/cuda

ENV DEBIAN_FRONTEND=noninteractive

# Ubuntu packages for tensorflow and pytorch aimet
RUN dpkg --add-architecture i386
RUN apt-get update > /dev/null && \
    apt-get install --no-install-recommends -y \
        build-essential \
        emacs \
        environment-modules \
        less \
        libavcodec-dev \
        libavformat-dev \
        libgtest-dev \
        libgtk2.0-dev \
        libsox-dev \
        libsox-fmt-all \
        libstdc++6:i386 \
        libswscale-dev \
        libxtst6 \
        lsb-release \
        meld \
        nano \
        pkg-config \
        python3-tk \
        sox \
        tree \
        vim && \
        rm -rf /var/lib/apt/lists/*

# Python3 Packages
RUN pip3 --no-cache-dir install \
        attrs==19.1.0 \
        behave==1.2.6 \
        blosc==1.8.1 \
        cffi==1.12.3 \
        click==7.0 \
        cython==0.29.10 \
        h5py==2.9.0 \
        ipykernel==4.8.2 \
        keras==2.2.4 \
        lmdb==0.95 \
        opencv-python==4.1.0.25 \
        pillow==6.2.1 \
        pluggy==0.12.0 \
        protobuf==3.7.1 \
        psutil==5.8.0 \
        ptflops==0.6.4 \
        pybind11==2.6.1 \
        pyDOE2==1.3.0 \
        pylint==2.3.1 \
        pymoo==0.4.1 \
        pytest==4.6.5 \
        pytest-cov==2.6.1 \
        pytorch-ignite==0.1.2 \
        https://download.pytorch.org/whl/cu100/torchvision-0.5.0%2Bcu100-cp36-cp36m-linux_x86_64.whl \
        https://download.pytorch.org/whl/cu100/torch-1.4.0%2Bcu100-cp36-cp36m-linux_x86_64.whl \
        scikit-image==0.15.0 \
        scikit-learn==0.21.0 \
        scipy==1.2.1 \
        sphinx==2.1.1 \
        sphinx-autodoc-typehints==1.6.0 \
        tensorboard==1.15 \
        tensorboardX==1.7 \
        tensorlayer==2.1.0 \
        timm==0.3.1 \
        torchtext==0.3.1 \
        tqdm==4.32.2 \
        wget==3.2 && \
    python3 -m ipykernel.kernelspec

RUN cd /tmp && \
    wget https://github.com/Kitware/CMake/releases/download/v3.19.3/cmake-3.19.3-Linux-x86_64.sh && \
    mkdir /opt/cmake && \
    sh cmake-3.19.3-Linux-x86_64.sh --prefix=/opt/cmake --skip-license

RUN ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake
RUN ln -s /opt/cmake/bin/ctest /usr/local/bin/ctest
RUN ln -s /opt/cmake/bin/cpack /usr/local/bin/cpack
ENV PATH=/usr/local/bin:$PATH

# Opencv
# Ref: https://docs.opencv.org/3.1.0/d7/d9f/tutorial_linux_install.html
RUN wget -q https://github.com/Itseez/opencv/archive/3.1.0.tar.gz -O /tmp/3.1.0.tar.gz > /dev/null && \
    tar -C /tmp -xvf /tmp/3.1.0.tar.gz > /dev/null && \
    cd /tmp/opencv-3.1.0 && mkdir release && cd release && \
    cmake -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=release -DWITH_FFMPEG=OFF -DBUILD_TESTS=OFF -DWITH_CUDA=OFF -DBUILD_PERF_TESTS=OFF -DWITH_IPP=OFF -DENABLE_PRECOMPILED_HEADERS=OFF .. > /dev/null && \
    make -j16 > /dev/null && \
    make -j16 install > /dev/null && \
    rm -rf /tmp/opencv-3.1.0*

EXPOSE 25000
RUN apt-get update && apt-get install -y openssh-server && rm -rf /var/lib/apt/lists/*
RUN mkdir /var/run/sshd

RUN apt-get update && apt-get install -y liblapacke liblapacke-dev && rm -rf /var/lib/apt/lists/*

# install pillow-simd.
RUN apt-get update && apt-get install -y libjpeg8-dev \
    cuda-cusparse-dev-10-0 \
    cuda-cublas-dev-10-0 \
    cuda-curand-dev-10-0 && \
    rm -rf /var/lib/apt/lists/*

# Set up symlink to point to the correct python version
RUN ln -sf /usr/bin/python3.6 /usr/bin/python
RUN ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib
RUN pip3 uninstall -y Pillow && pip3 install Pillow-SIMD==6.0.0.post0

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/Port 22/Port 25000/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Turn this into a development image
RUN cd / && git clone https://github.com/tensorflow/tensorflow.git && cd tensorflow && git checkout v1.15.0

RUN pip install git-pylint-commit-hook osqp==0.6.1 onnx==1.7.0

# bokeh requires Pillow while Pillow-SIMD is being used everywhere in Morpheus.
# To install bokeh, we are installing all dependencies of bokeh other than Pillow.
RUN mkdir /var/tmp/bokeh_hvplot_download
RUN pip download bokeh==1.2.0 hvplot==0.4.0 -d /var/tmp/bokeh_hvplot_download | grep Collecting | cut -d' ' -f2 | grep -Ev "pillow(~|=|\!|>|<|$)" | grep -Ev "bokeh(~|=|\!|>|<|$)"  | grep -Ev "hvplot(~|=|\!|>|<|$)" > /var/tmp/bokeh_hvplot_requirements.txt
RUN pip install --no-deps -r /var/tmp/bokeh_hvplot_requirements.txt
# NOTE: We need to pin the holoviews version to this since the latest version has a circular dependency on bokeh 2.0.0 through the panel package
RUN pip install holoviews==1.12.7 \
                netron==4.7.8

RUN pip install --no-deps bokeh==1.2.0 hvplot==0.4.0
RUN rm -rf /var/tmp/bokeh_hvplot_download /var/tmp/bokeh_hvplot_requirements.txt

RUN wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key|sudo apt-key add - && echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-11 main" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y clang-11 clang-format clang-tidy-11 cuda-cublas-dev-10-0 cuda-curand-dev-10-0 && \
   rm -rf /var/lib/apt/lists/*

# Create a version-less symbolic link for clang-tidy
RUN ln -s /usr/bin/run-clang-tidy-11.py /usr/bin/run-clang-tidy.py
