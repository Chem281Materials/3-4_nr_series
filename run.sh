#!/bin/sh

IMAGE=$(cat .podman/image_name)
PORT="${1:-0}"

if ! podman build -t "$IMAGE" .; then
    echo "Failed to pull image $IMAGE." >&2
    exit 1
fi

# Copy the run script from the image
CID=$(podman create $IMAGE)
podman cp $CID:/.podman/interface.sh .podman/interface.sh > /dev/null
podman rm -v $CID > /dev/null

# Run the image's interface script
if [ "$PORT" -eq 0 ]; then
    bash .podman/interface.sh $IMAGE
else
    bash .podman/interface.sh $IMAGE $PORT
fi
