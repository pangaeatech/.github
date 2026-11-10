FROM dhi.io/node:26-alpine-sfw-dev

RUN apk add -U bash dotnet10-sdk doxygen
RUN rm -Rf /var/cache/apk/*

CMD ["node"]
