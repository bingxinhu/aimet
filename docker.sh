
export AIMET_VARIANT="torch-gpu"
export WORKSPACE="/home/aimet"
export docker_image_name="aimet-dev-docker:1.19.1"
export docker_container_name="aimet-dev-haomo"

export PYTHONPATH=$PYTHONPATH:${WORKSPACE}/aimet
sudo docker build -t ${docker_image_name} -f $WORKSPACE/aimet/Jenkins/Dockerfile.${AIMET_VARIANT} .

sudo docker ps -a | grep ${docker_container_name} && docker kill ${docker_container_name}

sudo docker run --rm -it -u $(id -u ${USER}):$(id -g ${USER}) \
  -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro \
  -v ${HOME}:${HOME} -v ${WORKSPACE}:${WORKSPACE} \
  -v "/local/mnt/workspace":"/local/mnt/workspace" \
  --entrypoint /bin/bash -w ${WORKSPACE} --hostname ${docker_container_name} ${docker_image_name}
export PYTHONPATH=$WORKSPACE/build/staging/universal/lib/x86_64-linux-gnu:$WORKSPACE/build/staging/universal/lib/python:$PYTHONPATH
export LD_LIBRARY_PATH=$WORKSPACE/build/staging/universal/lib/x86_64-linux-gnu:$WORKSPACE/build/staging/universal/lib/python:$LD_LIBRARY_PATH

