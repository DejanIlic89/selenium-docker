FROM openjdk:8u191-jre-alpine3.8

# Install curl & jq
RUN apk add curl wget jq

# Workspace
WORKDIR /usr/share/udemy

# ADD .jar under target from host
# into this image
ADD target/selenium-docker.jar          selenium-docker.jar
ADD target/selenium-docker-tests.jar    selenium-docker-tests.jar
ADD target/libs                         libs

# in case of any other dependency like .csv / .json / .xls
# please ADD that as well

# ADD suite files
ADD book-flight-module.xml              book-flight-module.xml
ADD search-module.xml                   search-module.xml

# ADD health check script
# ADD healthcheck.sh                      healthcheck.sh

# Or we can ADD health check script the other way
# RUN curl -s https://s3.amazonaws.com/selenium-docker/healthcheck/healthcheck.sh
RUN wget -P . https://s3.amazonaws.com/selenium-docker/healthcheck/healthcheck.sh

# BROWSER
# HUB_HOST
# MODULE

ENTRYPOINT sh healthcheck.sh
