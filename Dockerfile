FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY build/bin/go-camo /bin/go-camo
ENTRYPOINT ["/bin/go-camo"]

