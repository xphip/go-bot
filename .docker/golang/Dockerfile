FROM golang:1.17.1-alpine AS build

RUN apk add gcc libc-dev

WORKDIR /go/src/app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .
RUN CGO_ENABLED=1 GOOS=linux go build -tags musl -o bin/app cmd/main.go

FROM golang:1.17.1-alpine
COPY --from=build /go/src/app/bin/app .

EXPOSE 8070

CMD [ "./app", "-env=false" ]
