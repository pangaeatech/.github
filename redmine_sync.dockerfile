FROM dhi.io/curl:8-alpine

RUN apk add -U bash jq pandoc zip unzip
RUN rm -Rf /var/cache/apk/*

COPY scripts/redmine_sync.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
