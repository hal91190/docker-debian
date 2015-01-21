# Debian image with french locales

FROM debian:unstable
MAINTAINER hal

ENV HOME=/root DEBIAN_FRONTEND=noninteractive

# Paramétrage de certains paquets
ADD preseed.txt /root/

# Installation des paquets de base
RUN debconf-set-selections /root/preseed.txt \
    && apt-get -y update \
    && apt-get -y install curl locales tzdata wget \
    && apt-get clean \
    && /usr/sbin/update-locale LANG=fr_FR.UTF-8

ENV LANG=fr_FR.UTF-8

CMD ["bash"]

