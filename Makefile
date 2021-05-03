#!/bin/bash

all: build run exec

start: run exec

build:
	docker build -t sysmocom:v5.0 . 
run:
	docker run -d --privileged --device=/dev/ttyUSB0 --name=sysmocom sysmocom:v5.0 
exec:
	docker exec -it sysmocom /bin/bash
stop:
	docker stop sysmocom && docker rm sysmocom
