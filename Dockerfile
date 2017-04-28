FROM hopobcn/pgi-ce:16.10-cuda8.0-devel-ubuntu16.04

# Install requirements
RUN apt-get update && apt-get install -y --no-install-recommends \
        cmake vim man-db && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/Hopobcn/FWI.git FWI && cd FWI && \
    git checkout gtc2017-sol-step1 && \
    git checkout gtc2017-sol-step2 && \
    git checkout gtc2017-sol-step3 && \
    git checkout gtc2017-sol-step4 && \
    git checkout gtc2017-sol-step5 && \
    git checkout gtc2017-sol-step6 && \
    cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-sol-step1 && cd FWI-sol-step1 && git checkout gtc2017-sol-step1 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-sol-step2 && cd FWI-sol-step2 && git checkout gtc2017-sol-step1 && git checkout gtc2017-sol-step2 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-sol-step3 && cd FWI-sol-step3 && git checkout gtc2017-sol-step2 && git checkout gtc2017-sol-step3 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-sol-step4 && cd FWI-sol-step4 && git checkout gtc2017-sol-step3 && git checkout gtc2017-sol-step4 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-sol-step5 && cd FWI-sol-step5 && git checkout gtc2017-sol-step4 && git checkout gtc2017-sol-step5 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-sol-step6 && cd FWI-sol-step6 && git checkout gtc2017-sol-step5 && git checkout gtc2017-sol-step6 && cd -
