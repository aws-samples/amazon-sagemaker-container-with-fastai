ARG REGION=us-west-2
ARG ARCH=cpu

# SageMaker PyTorch image
FROM 520713654638.dkr.ecr.$REGION.amazonaws.com/sagemaker-pytorch:1.0.0-$ARCH-py3

RUN python -m pip --no-cache-dir install --upgrade fastai

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8