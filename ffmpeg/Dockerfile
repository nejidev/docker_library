FROM alpine:latest
LABEL maintainer docker_user<nejidev@yahoo.co.jp>

RUN apk update 
RUN apk add build-base autoconf automake libtool openssl openssl-dev

ADD https://github.com/mstorsjo/fdk-aac/archive/v2.0.0.tar.gz /tmp
RUN cd /tmp && tar zxvf v2.0.0.tar.gz && cd fdk-aac-2.0.0 && ./autogen.sh && ./configure && make -j4 && make install && cd .. && rm -rf fdk-aac-2.0.0 v2.0.0.tar.gz

ADD http://ffmpeg.org/releases/ffmpeg-4.3.tar.gz /tmp
RUN cd /tmp && tar xzvf ffmpeg-4.3.tar.gz && cd ffmpeg-4.3 && \
./configure --disable-asm --enable-openssl --enable-static --disable-ffprobe --disable-ffplay \
--enable-encoder=libfdk_aac --enable-decoder=libfdk_aac --enable-libfdk-aac \
--enable-muxer=adts --disable-doc --disable-htmlpages --disable-podpages --disable-txtpages && \
make -j4 && make install && cd .. && rm -rf ffmpeg-4.3.tar.gz ffmpeg-4.3 && rm -rf /usr/local/lib/libav*.* && rm -rf /usr/local/lib/libsw*.*

