FROM debian:10-slim

RUN apt update \
    && apt upgrade \
    && apt install -y make git zlib1g-dev libssl-dev gperf php-cli cmake clang libc++-dev libc++abi-dev

RUN git clone https://github.com/tdlib/td.git \
&& cd td \
&& rm -rf build \
&& mkdir build \
&& cd build \
&& CXXFLAGS="-stdlib=libc++" CC=/usr/bin/clang CXX=/usr/bin/clang++ cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=../tdlib .. \
&& cmake --build . --target install \
&& cd .. \
&& cd .. \
&&  ls -l td/tdlib

CMD ["cp -L /td/tdlib/lib/libtdjson.so /libtdjson"]
