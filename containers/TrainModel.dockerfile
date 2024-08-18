# syntax = docker/dockerfile:1.0-experimental
FROM nvidia/cuda:12.3.2-runtime-ubuntu22.04
ENV PYTHONBUFFERED 1 ## To stream the output in the terminal.
RUN apt-get update && apt-get install -u python3 python3-pip sudo
RUN apt-get install -y --no-install-recommends git cmake build-essential python3.9 python3-pip python3-venv parallel nano

WORKDIR /workspace 

RUN mkdir /workspace/scripts/
RUN mkdir /workspace/runs/
RUN mkdir /workspace/venv
ENV VIRTUALENV=/workspace/venv/docker_segmentation
RUN cd /workspace/venv && python3 -m venv ${VIRTUALENV}
ENV PATH="${VIRTUALENV}/bin:$PATH"

RUN . "${VIRTUALENV}/bin/activate" && pip3 install --no-cache-dir poetry wheel setuptools

## Setting up WandB.
RUN --mount=type-secret,id=segmenter,dst=/workspace/segmenter-secret.env \ 
. /workspace/segmenter-secret.env && \
. "${VIRTUALENV}/bin/activate" && \
wandb login "$WANDB_API_TOKEN" --host "$WANDB_API_HOST"
RUN export PYTHON_KEYRING_BACKEND=keyring.backends.null.keyring

## Clone the relevant repository
RUN --mount=type=secret,id=segmenter,dst=/workspace/segmenter-secret.env \
. /workspace/segmenter-secret.env \
&& git clone "https://github.com/gvkannan-explore/AbdomenCT_Seg.git" /workspace/repos/AbdomenCT_Seg/
RUN cd /workspace/repos/AbdomenCT_Seg && . "${VIRTUALENV}/bin/activate" && pip3 install -r --no-cache-dir dev-requirements.txt

RUN apt-get clean ## Clean-up

