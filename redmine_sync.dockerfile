FROM dhi.io/debian-base:trixie-debian13-dev

RUN apt-get update
RUN apt-get install -y --no-install-recommends jq curl pandoc zip unzip
RUN rm -Rf /var/lib/apt/lists/*

COPY scripts/redmine_sync.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
