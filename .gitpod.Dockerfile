FROM gitpod/workspace-full-vnc

RUN sudo apt-get update && sudo apt-get install -y xschem ngspice

RUN git clone -b 8.3.460 https://github.com/RTimothyEdwards/magic && \
    cd magic && \
    ./configure  --without-opengl && \
    make -j4 && \
    sudo make install && \
    cd .. && sudo rm -rf magic

ENV PDK_ROOT="$HOME/.volare"
RUN pip install volare
RUN volare enable bdc9412b3e468c102d01b7cf6337be06ec6e9c9a
