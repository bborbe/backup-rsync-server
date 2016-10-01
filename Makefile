default: build

clean:
	docker rmi bborbe/backup-rsync-server

build:
	docker build --no-cache --rm=true -t bborbe/backup-rsync-server .

run:
	docker run -h example.com -p 2222:22 -v /tmp:/backup-rsync-server  bborbe/backup-rsync-server:latest

shell:
	docker run -i -t bborbe/backup-rsync-server:latest /bin/bash

upload:
	docker push bborbe/backup-rsync-server
