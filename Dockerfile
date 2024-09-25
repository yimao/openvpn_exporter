FROM golang:1.22 AS builder

WORKDIR /builder
COPY . .

RUN go mod download
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -trimpath -v -o openvpn_exporter

FROM scratch
COPY --from=builder /builder/openvpn_exporter /bin/openvpn_exporter
ENTRYPOINT ["/bin/openvpn_exporter"]
CMD ["-h"]
