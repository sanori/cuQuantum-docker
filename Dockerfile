FROM nvidia/cuda:11.4.3-runtime-ubuntu20.04

ARG cuquantum_version
RUN test -n "$cuquantum_version" || (echo "cuquantum_version is not set" && false)

ARG P_USER=user
ARG P_UID="1000"
ARG P_GID="1000"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update --yes && \
    apt-get upgrade --yes && \
    apt-get install --yes --no-install-recommends \
    ca-certificates \
    locales \
    libgomp1 \
    python3 python3-pip python-is-python3 \
    python3-typing-extensions \
    && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LD_LIBRARY_PATH=/usr/local/cuda/lib64

RUN useradd -l -m -s /bin/bash -N -u "${P_UID}" "${P_USER}"

ARG PYTHON_VERSION=default
WORKDIR /tmp
# cupy-cuda version should be the same as base image's cuda version
RUN pip install --no-cache-dir \
    cupy-cuda114 \
    cuquantum-python==${cuquantum_version}

USER ${P_USER}
WORKDIR /home/${P_USER}
