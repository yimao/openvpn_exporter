FROM golang:1.22 AS builder

WORKDIR /builder
COPY . .

ENV CGO_ENABLED=0
ENV GOOS: linux
ENV GOARCH: amd64

RUN go mod download
RUN go build -v -o openvpn_exporter -trimpath

FROM scratch
COPY --from=builder /builder/openvpn_exporter /bin/openvpn_exporter
ENTRYPOINT ["/bin/openvpn_exporter"]
CMD [ "-h" ]
