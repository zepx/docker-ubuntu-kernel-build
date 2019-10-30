FROM ubuntu:18.04

MAINTAINER Fx kirin <fx.kirin@gmail.com>

ENV KERNEL_MAJOR=4.15.0
ENV LOCALVERSION=-kirin
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN cp /etc/apt/sources.list /etc/apt/sources.list~
RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list

RUN apt-get update >/dev/null

RUN apt-get install -y apt-utils libncurses-dev flex bison openssl libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf linux-tools-$(uname -r) >/dev/null

RUN apt-get build-dep -y linux linux-image-$(uname -r)

RUN install --directory -m 0755 /data && \
    install --directory -m 0755 /patches

WORKDIR /data

VOLUME /data
VOLUME /patches

ADD scripts/kernel-build /usr/local/bin/kernel-build
RUN chmod 0755 /usr/local/bin/kernel-build

# we have to run as root so that we can apt-get update
ENTRYPOINT ["/usr/local/bin/kernel-build"]
