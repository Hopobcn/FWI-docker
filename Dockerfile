FROM hopobcn/pgi-ce:16.10-cuda8.0-devel-ubuntu16.04

# Install requirements
# -- If we install OmpSs from sources we need those packages:
#    autoconf automake libtool pkg-config libsqlite3-dev gperf flex bison gfortran
RUN apt-get update && apt-get install -y --no-install-recommends \
        cmake \
    rm -rf /var/lib/apt/lists/*
