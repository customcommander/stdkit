DOCKER_IMG_NAME=stdkit:latest

build: tmp/build

tmp/build: Dockerfile
	docker build -t $(DOCKER_IMG_NAME) .
	mkdir -p $(@D)
	touch $@

run:; docker run -it --rm $(DOCKER_IMG_NAME)
clean:; rm -rfv tmp

.PHONY: build run clean
