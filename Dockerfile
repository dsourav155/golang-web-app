FROM golang:1.22 as builder

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

# Explicitly set the target architecture
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

# final stage - Distroless image

FROM gcr.io/distroless/static-debian12:nonroot

WORKDIR /app

COPY --from=builder /app/main .

COPY --from=builder /app/static ./static

EXPOSE 8080

CMD [ "/app/main" ]

