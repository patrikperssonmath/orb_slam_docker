XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run -u $(id -u):$(id -g) --rm --gpus all -it \
 -v $1:/data:rw \
 -w /ORB_SLAM3 \
 --ipc=host \
 --net=host \
 --privileged \
 -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
 -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \
 -e DISPLAY \
 --env='XAUTHORITY=/tmp/.docker.xauth' \
  orb_slam
