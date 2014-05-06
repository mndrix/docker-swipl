.PHONY: all image push

all:
	@echo "There is no 'all' target"

# compile a Linux binary for SWI Prolog
distribute/swipl-binary.tgz: compiler/Dockerfile
	docker build -t swipl-compiler:latest compiler
	-docker rm -f swipl-binary
	docker run --name="swipl-binary" swipl-compiler /bin/bash
	-docker cp swipl-binary:swipl-binary.tgz .
	mv swipl-binary.tgz distribute/swipl-binary.tgz

image: distribute/Dockerfile distribute/swipl-binary.tgz
	docker build -t swipl:latest distribute

swipl-image.tgz:
	docker save swipl:latest > swipl-image.tar
	gzip -9 swipl-image.tar
	mv swipl-image.tar.gz swipl-image.tgz

push: swipl-image.tgz
	gsutil -m cp swipl-image.tgz gs://lending_club/
