FROM dhi.io/python:3-alpine-sfw-dev

RUN apk add -U bash jq curl pandoc zip unzip
RUN rm -Rf /var/cache/apk/*

CMD ["/bin/sh"]
