FROM postgres:latest
MAINTAINER "Frédéric Haziza <frederic.haziza@crg.eu>"

# Install Java Runtime Environment
RUN apt-get update && \
    apt-get install -y default-jre netcat && \
    rm -rf /var/lib/apt/lists/*

# Inject the Java code and copy the data inside
RUN mkdir /beacon
COPY beacon/ /beacon/

# Inject the db configuration
COPY db/db.sql           /docker-entrypoint-initdb.d/1-beacon-db.sql
COPY db/functions.sql    /docker-entrypoint-initdb.d/2-beacon-functions.sql

# Inject the data
COPY db/data/*  /beacon/
COPY db/load-data.sh  /usr/local/bin/beacon-load-data.sh
RUN chmod 755 /usr/local/bin/beacon-load-data.sh

EXPOSE 9075

COPY entrypoint.sh /beacon/entrypoint.sh
RUN chmod 755 /beacon/entrypoint.sh

WORKDIR /beacon
ENTRYPOINT ["/beacon/entrypoint.sh"]
