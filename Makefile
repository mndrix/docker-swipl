.PHONY: all image push

all:
	@echo "There is no 'all' target"

# compile a Linux binary for SWI Prolog
distribute/swipl-binary.tgz: compiler/Dockerfile
	docker pull debian:jessie
	docker build -t swipl-compiler:latest compiler
	-docker rm -f swipl-binary
	docker run --name="swipl-binary" swipl-compiler /bin/bash
	-docker cp swipl-binary:swipl-binary.tgz .
	mv swipl-binary.tgz distribute/swipl-binary.tgz

# build an image with SWI Prolog binary installed
image: distribute/Dockerfile distribute/swipl-binary.tgz
	docker build -t mndrix/swipl:latest distribute

# push changes to Docker's index
push:
	docker push mndrix/swipl:latest
