FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

RUN apt update
RUN apt install -qqy python python-dev cython curl gcc

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python get-pip.py

COPY hdrnet/requirements.txt /hdrnet/hdrnet/requirements.txt
WORKDIR /hdrnet/hdrnet

RUN pip install -r requirements.txt

COPY hdrnet /hdrnet/hdrnet

ENV TF_INC /usr/local/lib/python2.7/dist-packages/tensorflow/include
ENV TF_LIB /usr/local/lib/python2.7/dist-packages/tensorflow
RUN make

RUN apt install -qqy python-pytest python-opencv python-pil python-scipy
# RUN py.test test

COPY . /hdrnet
WORKDIR /hdrnet

# WORKDIR /hdrnet/benchmark
# RUN apt install -qqy pkg-config libglew-dev freeglut3-dev libopencv-dev libgflags-dev