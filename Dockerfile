FROM golang:1.20.1-bullseye as builder

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
COPY go.mod .
COPY go.sum .
COPY Makefile .
COPY pkg pkg/
COPY cmd cmd/
RUN make build


FROM alpine:latest as app
RUN apk add --no-cache ca-certificates
COPY --from=builder /workspace/build/bin/go-camo /bin/go-camo
ENTRYPOINT ["/bin/go-camo"]

