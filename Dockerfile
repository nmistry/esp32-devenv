FROM debian:latest
RUN apt-get update && apt-get install -y \
    automake \
    bison \
    build-essential \
    curl\
    flex \
    gawk \
    gcc \
    gettext \
    git \
    gperf \
    grep \
    help2man \
    less \
    libncurses-dev \
    libtool \
    libtool-bin \
    make \
    picocom\
    python \
    python-dev \
    python-serial \
    texinfo \
    tmux \
    wget \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /esp
WORKDIR /esp
RUN git clone -b xtensa-1.22.x https://github.com/espressif/crosstool-NG.git \
    && cd crosstool-NG \
    && ./bootstrap \
    && ./configure --enable-local \
    && make install

WORKDIR /esp/crosstool-NG  
RUN ./ct-ng xtensa-esp32-elf \
    && echo "CT_ALLOW_BUILD_AS_ROOT=y" >> .config \
    && echo "CT_ALLOW_BUILD_AS_ROOT_SURE=y" >> .config \
    && ./ct-ng build \
    chmod -R u+w builds/xtensa-esp32-elf

WORKDIR /esp
RUN git clone --recursive https://github.com/espressif/esp-idf.git

ENV IDF_PATH /esp/esp-idf
#ENV PATH /esp/xtensa-esp32-elf/bin:$PATH

