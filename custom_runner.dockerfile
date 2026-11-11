FROM dhi.io/debian-base:trixie-debian13-dev

RUN apt-get update
RUN apt-get install jq curl pandoc zip unzip dotnet10-sdk doxygen nodejs npm
RUN rm -Rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]
