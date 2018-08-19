VERSION ?= latest
REGISTRY ?= docker.io

default: build upload clean

clean:
	docker rmi $(REGISTRY)/bborbe/backup-rsync-server:$(VERSION)

build:
	docker build --no-cache --rm=true -t $(REGISTRY)/bborbe/backup-rsync-server:$(VERSION) .

upload:
	docker push $(REGISTRY)/bborbe/backup-rsync-server:$(VERSION)

run:
	docker run \
	--publish 2222:22 \
	--volume /tmp:/backup \
	$(REGISTRY)/bborbe/backup-rsync-server:$(VERSION)

shell:
	docker run -i -t $(REGISTRY)/bborbe/backup-rsync-server:$(VERSION) /bin/bash

