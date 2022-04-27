export AIMET_VARIANT="torch_gpu"
release_tag="1.19.1"
sudo python3 -m pip install https://github.com/quic/aimet/releases/download/${release_tag}/AimetCommon-${AIMET_VARIANT}_${release_tag}-cp36-cp36m-linux_x86_64.whl

# Install ONE of the following depending on the variant
sudo python3 -m pip install https://github.com/quic/aimet/releases/download/${release_tag}/AimetTorch-${AIMET_VARIANT}_${release_tag}-cp36-cp36m-linux_x86_64.whl -f https://download.pytorch.org/whl/torch_stable.html
# OR
sudo python3 -m pip install https://github.com/quic/aimet/releases/download/${release_tag}/Aimet-${AIMET_VARIANT}_${release_tag}-cp36-cp36m-linux_x86_64.whl

sudo cat /usr/local/lib/python3.6/dist-packages/aimet_common/bin/reqs_deb_common.txt | xargs apt-get --assume-yes install
#cat /usr/local/lib/python3.6/dist-packages/aimet_tensorflow/bin/reqs_deb_tf_gpu.txt | xargs apt-get --assume-yes install
sudo cat /usr/local/lib/python3.6/dist-packages/aimet_torch/bin/reqs_deb_torch_gpu.txt | xargs apt-get --assume-yes install

python3 -m pip uninstall -y pillow
python3 -m pip install --no-cache-dir Pillow-SIMD==6.0.0.post0

#wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
#mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.1.0/local_installers/cuda-repo-ubuntu1804-11-1-local_11.1.0-455.23.05-1_amd64.deb
dpkg -i cuda-repo-ubuntu1804-11-1-local_11.1.0-455.23.05-1_amd64.deb
apt-key add /var/cuda-repo-ubuntu1804-11-1-local/7fa2af80.pub
apt-get update
apt-get -y install cuda

wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
apt-get --assume-yes install ./nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
apt-get update

ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib
ln -s /usr/local/cuda-11.1 /usr/local/cuda

source /usr/local/lib/python3.6/dist-packages/aimet_common/bin/envsetup.sh

export LD_LIBRARY_PATH=/usr/local/lib/python3.6/dist-packages/aimet_common/x86_64-linux-gnu:/usr/local/lib/python3.6/dist-packages/aimet_common:$LD_LIBRARY_PATH

if [[ $PYTHONPATH = "" ]]; then 
	export PYTHONPATH=/usr/local/lib/python3.6/dist-packages/aimet_common/x86_64-linux-gnu; 
else 
	export PYTHONPATH=/usr/local/lib/python3.6/dist-packages/aimet_common/x86_64-linux-gnu:$PYTHONPATH; 
fi

