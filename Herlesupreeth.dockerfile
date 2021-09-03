FROM ubuntu:21.04

USER root 

ARG COMMIT=01627e0ec57bb5a79541cfb6934c2d8c8942f5b5
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        libpcsclite-dev \
        python3-pip \
        pcsc-tools \
        pcscd \
        swig \
        git \
        vim && \
    apt-get clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /root
RUN git clone -b master https://github.com/herlesupreeth/pysim && \
    cd pysim && \
    git reset --hard $COMMIT && \
    ln -s /root/pysim/pySim-prog.py /bin/writesim

WORKDIR /root/pysim

RUN pip3 install -r requirements.txt

ENTRYPOINT [ "pcscd", "-f"]