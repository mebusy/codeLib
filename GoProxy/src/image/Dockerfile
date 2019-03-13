
FROM alpine:3.9

COPY . /opt/app

# Change work directory
WORKDIR /opt/app


# COPY service runner
COPY service.sh /usr/bin/
RUN chmod +x /usr/bin/service.sh

CMD []
ENTRYPOINT ["service.sh"]

