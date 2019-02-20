# Dockerfile
FROM centos:6.7
ENV MAKEFLAGS="-j8" PYTHON_VERSION="2.6.9"
RUN yum install --quiet --assumeyes \
        ca-certificates \
        epel-release \
    && \
    PYTHON_BUILD_PKGS="\
        bzip2-devel \
        cloog-ppl \
        cpp \
        file \
        gcc \
        gdbm-devel \
        glibc-devel \
        glibc-headers \
        kernel-headers \
        libgomp \
        mpfr \
        ncurses-devel \
        ppl \
        readline-devel \
        sqlite-devel \
        sqlite2 \
        sqlite2-devel \
        tar \
        wget \
        zlib-devel \
    " && \
    yum install --assumeyes \
        ${PYTHON_BUILD_PKGS} \
        python-pip \
        python-virtualenv \
    && \
    wget "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz" && \
    tar zxf "/Python-${PYTHON_VERSION}.tgz" && \
    cd "Python-${PYTHON_VERSION}" && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    cd .. && \
    rm -rf "/Python-${PYTHON_VERSION}" "/Python-${PYTHON_VERSION}.tgz" /var/cache/yum/x86_64/6/ && \
    ln -s python2.6 /usr/local/bin/python2 && \
    yum remove --assumeyes ${PYTHON_BUILD_PKGS} && \
    mkdir /src
WORKDIR /src
