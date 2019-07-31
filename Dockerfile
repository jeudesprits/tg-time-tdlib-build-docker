FROM debian:9-slim

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends apt-utils dialog 2>&1 \        
    #
    # Install locales
    && apt-get install -y locales git \
    #
    # Install deps. to build TDLib (Telegram Database library)
    && apt-get install -y make zlib1g-dev libssl-dev gperf php cmake clang libc++-dev \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    #
    # Set locale
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=

ENV LANG en_US.utf8

RUN git clone https://github.com/tdlib/td.git \
    && cd td \
    && rm -rf build \
    && mkdir build \
    && cd build \
    && export CXXFLAGS="-stdlib=libc++" \
    && CC=/usr/bin/clang CXX=/usr/bin/clang++ cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=../tdlib .. \
    && cmake --build . --target prepare_cross_compiling \
    && cd .. \
    && php SplitSource.php \
    && cd build \
    && cmake --build . --target install \
    && cd .. \
    && php SplitSource.php --undo \
    && cd .. 

CMD ["cp -L /td/tdlib/lib/libtdjson.so /libtdjson"]
