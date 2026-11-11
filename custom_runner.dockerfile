FROM dhi.io/python:3-alpine-sfw-dev

RUN apk add -U bash jq curl pandoc zip unzip dotnet10-sdk doxygen nodejs npm
RUN rm -Rf /var/cache/apk/*

ENTRYPOINT ["/bin/bash"]
