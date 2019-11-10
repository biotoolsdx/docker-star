FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Chen Yuelong <yuelong.chen.btr@gmail.com>

ARG star_version=2.7.1a
ARG samtools_version=1.9


# Update the repository sources list
RUN apt-get update && apt-get install --yes \
 build-essential \
 gcc-multilib \
 apt-utils \
 zlib1g-dev git wget autoconf automake make gcc perl bzip2 \
                          zlib1g-dev libbz2-dev \
                          liblzma-dev libcurl4-gnutls-dev libssl-dev libncurses5-dev

# Install git


# Install STAR
WORKDIR /tmp/
RUN git clone https://github.com/alexdobin/STAR.git && cd STAR/ && \
        git checkout $star_version && \
        cd source/ && \
        make && ls ./ && cp -p STAR /usr/local/bin && \
        cd /tmp/ && \
        wget -c https://github.com/samtools/samtools/releases/download/$samtools_version/samtools-$samtools_version.tar.bz2 && \
        tar -jxvf samtools-$samtools_version.tar.bz2 && \
        cd samtools-$samtools_version && \
        ./configure && make && make install
RUN rm -rf /tmp/* && apt-get clean && apt-get remove --yes --purge build-essential \
    gcc-multilib apt-utils zlib1g-dev git  wget

# Set default working path
CMD bash