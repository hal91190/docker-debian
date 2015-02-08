# Debian image with french locales and timezone

FROM debian:testing
MAINTAINER hal

ENV HOME=/root DEBIAN_FRONTEND=noninteractive

# update package cache
RUN apt-get -y update

# Setup locales
RUN echo "locales locales/locales_to_be_generated multiselect fr_FR.UTF-8 UTF-8" | debconf-set-selections \
 && echo "locales locales/default_environment_locale select fr_FR.UTF-8" | debconf-set-selections \
 && apt-get -y install locales \
 && /usr/sbin/update-locale LANG=fr_FR.UTF-8

ENV LANG=fr_FR.UTF-8

# Setup timezone
RUN echo "tzdata tzdata/Areas select Europe" | debconf-set-selections \
 && echo "tzdata tzdata/Zones/Europe select Paris" | debconf-set-selections \
 && echo "Europe/Paris" > /etc/timezone \
 && apt-get -y install tzdata

# Clean package cache
RUN apt-get clean

CMD ["bash"]

