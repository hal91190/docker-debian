# Debian image with french locales and timezone

FROM debian:testing
MAINTAINER hal

# update package cache
RUN apt-get -y update

# Setup locales
RUN echo "locales locales/locales_to_be_generated multiselect fr_FR.UTF-8 UTF-8" | debconf-set-selections \
 && echo "locales locales/default_environment_locale select fr_FR.UTF-8" | debconf-set-selections \
 && apt-get -y install locales \
 && /usr/sbin/update-locale LANG=fr_FR.UTF-8

ENV LANG=fr_FR.UTF-8 LANGUAGE=fr_FR:fr LC_ALL=fr_FR.UTF-8

# Setup timezone
RUN echo "Europe/Paris" > /etc/timezone \
 && dpkg-reconfigure -f noninteractive tzdata

# Clean package cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["bash"]

