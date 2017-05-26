FROM lroguet/rpi-home-assistant:0.45.1
MAINTAINER Alex van Assem <avassem@gmail.com>

# Base layer
ENV ARCH=arm
ENV CROSS_COMPILE=/usr/bin/
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Copy build scripts
COPY scripts/ scripts/
RUN scripts/install_prereqs

# Install hass component dependencies
COPY requirements_all.txt requirements_all.txt
RUN pip3 install -vvv --upgrade setuptools && \
    pip3 install -vvv --no-cache-dir -r requirements_all.txt && \
    pip3 install -vvv --no-cache-dir mysqlclient psycopg2 uvloop cchardet