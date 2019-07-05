FROM byrnedo/alpine-curl:latest

RUN apk add --update bash

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT [ "entrypoint.sh" ]