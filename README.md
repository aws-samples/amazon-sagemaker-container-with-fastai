# Amazon SageMaker Container Example with fast.ai

This project allows you to build a Docker container to build, train and deploy [fast.ai](https://github.com/fastai/fastai) based Deep Learning models with Amazon SageMaker.

Since the fast.ai library is based on PyTorch, this project builds upon the [SageMaker PyTorch Container](https://github.com/aws/sagemaker-pytorch-container) meaning that you can bring your own fast.ai scripts for training and deploying your models using the [PyTorch](https://sagemaker.readthedocs.io/en/latest/sagemaker.pytorch.html) Estimator, Model and Predictor objects in the [SageMaker SDK](https://sagemaker.readthedocs.io/en/latest/). 

## Getting Started

[Amazon SageMaker](https://aws.amazon.com/documentation/sagemaker/) utilizes Docker containers to run all training jobs & inference endpoints. Make sure you have installed [Docker](https://www.docker.com/>) on your development machine in order to build the necessary Docker images.

The Docker images are built from the [following Dockerfile](https://github.com/aws-samples/amazon-sagemaker-container-with-fastai/tree/master/Dockerfile>).

We have a utility script that builds 2 Docker images, a GPU based image and a CPU based image, on your machine locally and pushes them to your ECR repository.

To build the images run the following script:

```
./build_and_push.sh

```

## License Summary

This sample code is made available under a modified MIT license. See the LICENSE file.
