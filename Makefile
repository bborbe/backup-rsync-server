VERSION ?= latest
REGISTRY ?= docker.io

default: build upload clean

clean:
	docker rmi $(REGISTRY)/bborbe/backup-rsync-server:$(VERSION)

build:
	docker build --build-arg VERSION=$(VERSION) --no-cache --rm=true -t $(REGISTRY)/bborbe/backup-rsync-server:$(VERSION) .

run:
	docker run -h example.com -p 2222:22 -v /tmp:/backup-rsync-server  $(REGISTRY)/bborbe/backup-rsync-server:$(VERSION)

shell:
	docker run -i -t $(REGISTRY)/bborbe/backup-rsync-server:$(VERSION) /bin/bash

upload:
	docker push $(REGISTRY)/bborbe/backup-rsync-server:$(VERSION)
