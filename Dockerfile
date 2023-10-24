# build and run go application
FROM golang:1.19-alpine AS builder

WORKDIR /build

COPY . .

RUN go mod download

RUN go build -o main .
# RUN CGO_ENABLED=0 go build -gcflags "all=-N -l" -o main .

FROM alpine:3.13

WORKDIR /app

COPY --from=builder /build/main .

EXPOSE 8080

CMD ["./main"]
