FROM alpine:3.13 as builder

RUN apk add --no-cache git make g++ boost-dev openssl-dev db-dev miniupnpc-dev zlib-dev
RUN addgroup --gid 1000 emark
RUN adduser --disabled-password --gecos "" --home /emark --ingroup emark --uid 1000 emark

USER emark

RUN git clone https://github.com/emarkproject/eMark.git /emark/eMark
WORKDIR /emark/eMark
RUN git checkout tags/1.6.1.1
WORKDIR /emark/eMark/src
RUN make -f makefile.unix

FROM alpine:3.13

RUN apk add --no-cache boost-dev db-dev miniupnpc-dev zlib-dev bash curl
RUN addgroup --gid 1000 emark
RUN adduser --disabled-password --gecos "" --home /emark --ingroup emark --uid 1000 emark

USER emark
COPY --from=builder /emark /emark
COPY ./entrypoint.sh /

RUN mkdir /emark/.eMark
VOLUME /emark/.eMark
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 5556/tcp
EXPOSE 6666/tcp
