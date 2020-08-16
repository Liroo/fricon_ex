FROM alpine:latest

WORKDIR /usr/src/app

RUN apk update \
    && apk --no-cache --update add bash
  
COPY ./entrypoint.sh /usr/src/app

CMD echo "cmd"
ENTRYPOINT [ "/usr/src/app/entrypoint.sh" ]