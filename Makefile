VERSION ?= 1.0.0

default: build

clean:
	docker rmi bborbe/backup-rsync-server:$(VERSION)

build:
	docker build --build-arg VERSION=$(VERSION) --no-cache --rm=true -t bborbe/backup-rsync-server:$(VERSION) .

run:
	docker run -h example.com -p 2222:22 -v /tmp:/backup-rsync-server  bborbe/backup-rsync-server:$(VERSION)

shell:
	docker run -i -t bborbe/backup-rsync-server:$(VERSION) /bin/bash

upload:
	docker push bborbe/backup-rsync-server:$(VERSION)
