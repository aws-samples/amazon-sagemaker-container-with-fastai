ARG BASE_IMAGE=ubuntu:16.04

FROM $BASE_IMAGE

ARG PYTORCH_PACKAGE=torch
ARG PYTHON_VERSION=3.7

RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        ca-certificates \
        cmake \
        wget \
        git \
        vim \
        libsm6 \
        libxext6 \
        libxrender-dev \
        nginx \
        jq \
        bc \
        && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        software-properties-common \
        && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        python${PYTHON_VERSION} \
        python${PYTHON_VERSION}-dev \
        python${PYTHON_VERSION}-tk \
        && \
    wget -q -O ~/get-pip.py \
        https://bootstrap.pypa.io/get-pip.py && \
    python${PYTHON_VERSION} ~/get-pip.py && \
    ln -s /usr/bin/python${PYTHON_VERSION} /usr/local/bin/python3 && \
    ln -s /usr/bin/python${PYTHON_VERSION} /usr/local/bin/python && \
    $PIP_INSTALL ${PYTORCH_PACKAGE} && \
    $PIP_INSTALL torchvision \
        numpy \
        sagemaker-containers>=2.3.5 \
        retrying \
        six && \
    $PIP_INSTALL fastai && \
    ldconfig && \ 
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

# Clone the SageMaker PyTorch project and install the package and other files
RUN git clone https://github.com/aws/sagemaker-pytorch-container --depth=1 /opt/sagemaker-pytorch-container && \
    cp /opt/sagemaker-pytorch-container/lib/changehostname.c / && \
    cp /opt/sagemaker-pytorch-container/lib/start_with_right_hostname.sh /usr/local/bin/start_with_right_hostname.sh && \
    cd /opt/sagemaker-pytorch-container && \
    python setup.py bdist_wheel && \
    python -m pip --no-cache-dir install --no-deps --upgrade /opt/sagemaker-pytorch-container/dist/sagemaker_pytorch_container-1.1-py2.py3-none-any.whl && \
    chmod +x /usr/local/bin/start_with_right_hostname.sh && \
    rm -rf /opt/sagemaker-pytorch-container

# Python won’t try to write .pyc or .pyo files on the import of source modules
# Force stdin, stdout and stderr to be totally unbuffered. Good for logging
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1

ENV SAGEMAKER_TRAINING_MODULE sagemaker_pytorch_container.training:main
ENV SAGEMAKER_SERVING_MODULE sagemaker_pytorch_container.serving:main

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

WORKDIR /

# Starts framework
ENTRYPOINT ["bash", "-m", "start_with_right_hostname.sh"]
