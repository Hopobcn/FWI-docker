FROM hopobcn/pgi-ce:16.10-cuda8.0-devel-ubuntu16.04

# Install requirements
RUN apt-get update && apt-get install -y --no-install-recommends \
        cmake vim && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/Hopobcn/FWI.git FWI-step0 && \
    git clone https://github.com/Hopobcn/FWI.git FWI-step1 && cd FWI-step1 && git checkout gtc2017-sol-step1 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-step2 && cd FWI-step2 && git checkout gtc2017-sol-step2 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-step3 && cd FWI-step3 && git checkout gtc2017-sol-step3 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-step4 && cd FWI-step4 && git checkout gtc2017-sol-step4 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-step5 && cd FWI-step5 && git checkout gtc2017-sol-step5 && cd - && \
    git clone https://github.com/Hopobcn/FWI.git FWI-step6 && cd FWI-step6 && git checkout gtc2017-sol-step6 && cd -
