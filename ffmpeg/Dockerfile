FROM ubuntu:latest
LABEL maintainer docker_user<nejidev@yahoo.co.jp>

RUN apt-get update && apt-get install -y gawk build-essential g++ automake libtool bzip2 libssl-dev && rm -rf /var/lib/apt/lists/

ADD https://github.com/mstorsjo/fdk-aac/archive/v2.0.0.tar.gz /tmp
RUN cd /tmp && tar zxvf v2.0.0.tar.gz && cd fdk-aac-2.0.0 && ./autogen.sh && ./configure && make -j4 && make install && ldconfig && cd .. && rm -rf fdk-aac-2.0.0 v2.0.0.tar.gz

ADD http://ffmpeg.org/releases/ffmpeg-4.3.tar.gz /tmp
RUN cd /tmp && tar xzvf ffmpeg-4.3.tar.gz && cd ffmpeg-4.3 && \
./configure --disable-asm --enable-openssl --enable-shared \
--enable-encoder=libfdk_aac --enable-decoder=libfdk_aac --enable-libfdk-aac \
--enable-muxer=adts --disable-doc --disable-htmlpages --disable-podpages --disable-txtpages && \
make -j4 && make install && ldconfig && cd .. && rm -rf ffmpeg-4.3.tar.gz ffmpeg-4.3


