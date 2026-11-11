FROM dhi.io/alpine-base:3.24-dev

RUN apk add -U bash curl jq pandoc zip unzip
RUN rm -Rf /var/cache/apk/*

COPY scripts/redmine_sync.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
