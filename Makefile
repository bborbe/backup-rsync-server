default: build

build:
	docker build --rm=true -t bborbe/backup-rsync .

run:
	docker run -h example.com -p 22:22 -v /tmp:/backup-rsync  bborbe/backup-rsync:latest

bash:
	docker run -i -t bborbe/backup-rsync:latest /bin/bash

upload:
	docker push bborbe/backup-rsync
