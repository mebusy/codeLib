
FROM alpine:3.9

COPY . /opt/app

# Change work directory
WORKDIR /opt/app


# COPY umc-service runner
COPY umc-service.sh /usr/bin/
RUN chmod +x /usr/bin/umc-service.sh

ENTRYPOINT ["umc-service.sh"]

