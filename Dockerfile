FROM alpine:latest

RUN set -x  \
       && apk add scsi-tgt scsi-tgt-scripts                                                                                        0.0s
COPY targets.conf /etc/tgt/targets.conf                                                                                                        0.0s
COPY entrypoint.sh /                                                                                                                           0.0s
EXPOSE 3260

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]