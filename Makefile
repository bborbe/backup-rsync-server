default: build

clean:
	docker rmi bborbe/backup-rsync

build:
	docker build --rm=true -t bborbe/backup-rsync .

run:
	docker run -h example.com -p 2222:22 -v /tmp:/backup-rsync  bborbe/backup-rsync:latest

shell:
	docker run -i -t bborbe/backup-rsync:latest /bin/bash

upload:
	docker push bborbe/backup-rsync
