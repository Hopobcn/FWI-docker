FROM hopobcn/pgi-ce:17.4-cuda8.0-devel-ubuntu16.04

# Install requirements
# -- If we install OmpSs from sources we need those packages:
#    autoconf automake libtool pkg-config libsqlite3-dev gperf flex bison gfortran
RUN apt-get update && apt-get install -y --no-install-recommends \
        cmake vim emacs nano man-db python3 sudo ssh openssl && \
    wget -cO ompss-acc.tar.gz "https://www.dropbox.com/s/gxemuscqs9n4igy/ompss-acc-gtc2017eu.tar.gz?dl=0" && \
    tar zxf ompss-acc.tar.gz && \
    mv ompss /usr/local/ompss && \
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
RUN mkdir -p /home/ubuntu/labs && \
    cd /home/ubuntu/labs && \
    git clone https://github.com/Hopobcn/FWI.git FWI && cd FWI && \
    git checkout gtc2017-sol-step1 && \
    git checkout gtc2017-sol-step2 && \
    git checkout gtc2017-sol-step3 && \
    git checkout gtc2017-sol-step4 && \
    git checkout gtc2017-sol-step5 && \
    git checkout gtc2017-sol-step6 && \
    git checkout ompss-openacc && \
    git checkout gtc2017 && \
    cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-sol-step1 && cd FWI-sol-step1 && git checkout gtc2017-sol-step1 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-sol-step2 && cd FWI-sol-step2 && git checkout gtc2017-sol-step1 && git checkout gtc2017-sol-step2 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-sol-step3 && cd FWI-sol-step3 && git checkout gtc2017-sol-step2 && git checkout gtc2017-sol-step3 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-sol-step4 && cd FWI-sol-step4 && git checkout gtc2017-sol-step3 && git checkout gtc2017-sol-step4 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-sol-step5 && cd FWI-sol-step5 && git checkout gtc2017-sol-step4 && git checkout gtc2017-sol-step5 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-sol-step6 && cd FWI-sol-step6 && git checkout gtc2017-sol-step5 && git checkout gtc2017-sol-step6 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-sol-ompss-acc && cd FWI-sol-ompss-acc && git checkout ompss-openacc && cd -


