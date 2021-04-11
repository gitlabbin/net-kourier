FROM golang:1.15
WORKDIR /app/
COPY go.mod go.sum ./
COPY . .
#RUN CGO_ENABLED=0 GOOS=linux go build -mod vendor -a -installsuffix cgo -o kourier cmd/kourier/main.go
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o kourier cmd/kourier/main.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates
USER 1001
COPY --from=0 /app/kourier /app/kourier
EXPOSE 18000 19000
CMD ["/app/kourier"]