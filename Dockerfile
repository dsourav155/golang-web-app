FROM golang:1.21.10 as builder

WORKDIR /app

COPY go.mod .

RUN export GOVCS=false
RUN go mod download

COPY . .
RUN export GOVCS=false
RUN go build  -o main -buildvcs=false

# final stage - Distroless image

FROM gcr.io/distroless/static-debian12:nonroot

WORKDIR /app

COPY --from=builder /app/main .

COPY --from=builder /app/static ./static

EXPOSE 8080

CMD [ "/app/main" ]

