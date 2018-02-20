FROM hopobcn/pgi-ce:17.4-cuda8.0-devel-ubuntu16.04

# Install requirements
# -- If we install OmpSs from sources we need those packages:
#    autoconf automake libtool pkg-config libsqlite3-dev gperf flex bison gfortran
RUN apt-get update && apt-get install -y --no-install-recommends \
        vim emacs nano man-db python3 sudo ssh openssl git wget ca-certificates && \
    wget -cO ompss-acc.tar.gz "https://www.dropbox.com/s/gxemuscqs9n4igy/ompss-acc-gtc2017eu.tar.gz?dl=0" && \
    tar -zxf ompss-acc.tar.gz && mv ompss /usr/local/ompss && \
    wget https://cmake.org/files/v3.10/cmake-3.10.2.tar.gz && \
    tar -xvf cmake-3.10.2.tar.gz && cd cmake-3.10.2/ && ./bootstrap && make -j4 && sudo make install && cd - && \
    rm -rf cmake-3.10.2/ cmake-3.10.2.tar.gz && \
    rm -f ompss-acc.tar.gz && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash -N ubuntu && \
    adduser ubuntu sudo && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-docker-ubuntu

USER ubuntu
WORKDIR /home/ubuntu

ENV OMPSS_HOME     "/usr/local/ompss"
ENV NANOS_HOME     "${OMPSS_HOME}"/nanox-0.13a-acc
ENV MCXX_HOME      "${OMPSS_HOME}"/mcxx-2.1-acc

ENV NANOS_BIN_DIR  "${NANOS_HOME}"/bin
ENV NANOS_LIB_DIR  "${NANOS_HOME}"/lib/performance

ENV MCXX_BIN_DIR   "${MCXX_HOME}"/bin
ENV MCXX_LIB_DIR   "${MCXX_HOME}"/lib

ENV PATH            "${PATH}:${NANOS_BIN_DIR}:${MCXX_BIN_DIR}"
ENV LD_LIBRARY_PATH "${LD_LIBRARY_PATH}:${NANOS_LIB_DIR}:${MCXX_LIB_DIR}"

# Install LAB source code
RUN cd /home/ubuntu && \
    git clone https://github.com/Hopobcn/FWI.git FWI && cd FWI && \
    git checkout ompss-openacc && \
    git checkout gtc2018-step5-sol && \
    git checkout gtc2018-step4-sol && \
    git checkout gtc2018-step3-sol && \
    git checkout gtc2018-step1-sol && \
    git checkout gtc2018-step5 && \
    git checkout gtc2018-step4 && \
    git checkout gtc2018-step3 && \
    git checkout gtc2018-step2 && \
    git checkout gtc2018-step1 && \
    git submodule update --init --recursive && \
    cd -


