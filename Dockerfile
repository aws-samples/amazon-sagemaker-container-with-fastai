ARG REGION=us-west-2

# SageMaker PyTorch image
FROM 520713654638.dkr.ecr.$REGION.amazonaws.com/sagemaker-pytorch:1.0.0-gpu-py3

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

