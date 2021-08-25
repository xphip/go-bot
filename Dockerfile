FROM golang:1.16.7-alpine

WORKDIR /go/src/app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o bin/app cmd/main.go

FROM golang:1.16.7-alpine
COPY --from=build /go/src/app/bin/app .
CMD [ "./app", "-env=false" ]
