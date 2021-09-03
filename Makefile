#!/bin/bash

all: build run exec

start: run exec

build:
	docker build -t pysim:v5.0 . 
run:
	docker run -d --privileged --device=/dev/ttyUSB0 --name=pysim pysim:v5.0 
exec:
	docker exec -it pysim /bin/bash
stop:
	docker stop pysim && docker rm pysim
