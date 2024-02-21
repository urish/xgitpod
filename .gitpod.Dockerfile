FROM gitpod/workspace-full-vnc

ARG MAGIC_VERSION=8.3.460
ARG NETGEN_VERSION=1.5.270
ARG KLAYOUT_VERSION=0.28.17
ARG XSCHEM_VERSION=3.4.4

RUN sudo apt-get update && sudo apt-get install -y ngspice

RUN git clone -b $MAGIC_VERSION https://github.com/RTimothyEdwards/magic && \
    cd magic && \
    ./configure  --without-opengl && \
    make -j4 && \
    sudo make install && \
    cd .. && sudo rm -rf magic

RUN git clone -b $NETGEN_VERSION https://github.com/RTimothyEdwards/netgen netgen && \
    cd netgen && \
    ./configure && \
    make -j4 && \
    sudo make install && \
    cd .. && sudo rm -rf netgen

RUN sudo apt-get install -y flex bison libxpm4 libxpm-dev
RUN git clone -b $XSCHEM_VERSION https://github.com/StefanSchippers/xschem xschem && \
    cd xschem && \
    ./configure && \
    make -j4 && \
    sudo make install && \
    cd .. && rm -rf xschem

RUN curl -o /tmp/klayout.deb https://www.klayout.org/downloads/Ubuntu-22/klayout_$KLAYOUT_VERSION-1_amd64.deb && \
    sudo apt-get install -y /tmp/klayout.deb && \
    rm /tmp/klayout.deb

ENV PDK_ROOT="$HOME/.volare"
RUN pip install volare
RUN volare enable bdc9412b3e468c102d01b7cf6337be06ec6e9c9a
