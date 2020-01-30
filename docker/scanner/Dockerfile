FROM debian:latest

RUN apt-get upgrade && apt-get update && apt-get install -y wget zip procps openjdk-11-jre

RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip -O /usr/local/sonar-scanner.zip && \
    cd /usr/local/ && \
    unzip sonar-scanner && \
    mv sonar-scanner-4.2.0.1873-linux sonar-scanner && \
    ln -s /usr/local/sonar-scanner/bin/sonar-scanner /usr/bin/sonar-scanner

RUN mkdir /var/www

WORKDIR /var/www
