FROM alpine:latest

RUN set -x  \
       && apk add scsi-tgt scsi-tgt-scripts 
COPY targets.conf /etc/tgt/targets.conf
COPY entrypoint.sh /
EXPOSE 3260

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
