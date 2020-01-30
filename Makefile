EXEC = docker-compose exec sonarserver
DID = $$(docker-compose ps -q sonarserver)

GREEN = $$(tput setaf 2)
YELLOW = $$(tput setaf 3)
RESET = $$(tput sgr0)

all: help

help:                  #~ Show this help
	@fgrep -h "#~"  $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e "s/^\([^:]*\):/${GREEN}\1${RESET}/;s/#~r/${RESET}/;s/#~y/${YELLOW}/;s/#~ //"

#~y
#~ Project Setup
#~ ________________________________________________________________
#~r

install:               #~ Install and start the project
install: build start

build:                 #~ Build docker containers
	docker-compose build

start:                 #~ Start the docker containers
	docker-compose up -d

stop:                  #~ Stop the docker containers
	docker-compose stop

clean:                 #~ Clean the docker containers
clean: stop
	docker-compose rm

destroy:               #~ Remove all docker images
destroy: stop
	docker-compose down --rmi all

.PHONY: install build composer-install-run start stop clean destroy

#~y
#~ SonarQube
#~ ________________________________________________________________
#~r

console:               #~ Open the console in SonarQube Server docker
	$(EXEC) bash

logs:                  #~ Show all logs [CTRL]+[C] to exit
	docker-compose logs -f sonarserver

error-logs:            #~ Show error logs only [CTRL]+[C] to exit
	docker logs -f $(DID) >/dev/null

scan:                  #~ Scan a project, use ARGS=... to specified the path
	docker run --network=sonarqube_sonarqube -v $$(realpath ${ARGS}):/var/www -it docker-sonarqube_sonarscanner bash -c "sonar-scanner -Dsonar.host.url=http://sonarserver:9000 -X"

.PHONY: console logs error-logs scan
