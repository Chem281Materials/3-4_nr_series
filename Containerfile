from docker.io/taylorabarnes/devenv:latest

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y \
                       cmake \
                       g++ \
                       git
