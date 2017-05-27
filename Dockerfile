FROM resin/raspberrypi3-python:3
MAINTAINER Alex van Assem <avassem@gmail.com>

# Base layer
# ENV ARCH=arm
# ENV CROSS_COMPILE=/usr/bin/
# ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Copy build scripts
COPY scripts/ scripts/
RUN scripts/install_prereqs

# Install Home Assistant
RUN pip install --upgrade pip
RUN pip install -v --upgrade setuptools
RUN pip install homeassistant==0.45.1

# Install hass component dependencies
# COPY requirements_all.txt requirements_all.txt
# RUN pip install -v --no-cache-dir -r requirements_all.txt && \
#     pip install -v --no-cache-dir mysqlclient psycopg2 uvloop cchardet

# Mouting point for the user's configuration
VOLUME /config

# Start Home Assistant
CMD [ "python", "-m", "homeassistant", "--config", "/config" ]