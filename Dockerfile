FROM ubuntu:18.04

USER root 

ARG COMMIT=278816251d3201d233d169fd4fbde821f13624db
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

RUN pip3 install --no-cache-dir \
        pyscard \
        serial \
        pytlv \
        cmd2 \
        pyYAML \
        ply \ 
        decorator \
        jsonpath-ng \
        construct

WORKDIR /root
RUN git clone -b master git://git.osmocom.org/pysim && \
    cd pysim && \
    git reset --hard $COMMIT && \
    ln -s /root/pysim/pySim-prog.py /bin/writesim

ENTRYPOINT [ "pcscd", "-f"]