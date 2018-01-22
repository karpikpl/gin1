export GOPATH

VERSION ?= $(shell git describe --tags --always --dirty)
DIR_BIN = ./bin
DIR_PKG = ./pkg

default: build

build: install vet compile

verify: fmt vet lint compile test

compile:
	go build -v -o ${DIR_BIN}/easiest \
	-ldflags "-X main.Version=${VERSION}" \
	./main.go

install:
	glide install

test:
	go test ./... -v

test-cover:
	go test . -test.coverprofile=coverageReport.out -test.v=true

bench:
	go test ./... -test.bench=".*" -test.v=true

doc:
	godoc -http=:6060 -index

# http://golang.org/cmd/go/#hdr-Run_gofmt_on_package_sources
fmt:
	go fmt ./...

# https://github.com/golang/lint
# go get github.com/golang/lint/golint
lint:
	golint ${DIR_PKG}/... .

# http://godoc.org/code.google.com/p/go.tools/cmd/vet
# go get code.google.com/p/go.tools/cmd/vet
vet:
	go vet ${DIR_PKG}/... .

run:
	go run main.go -p=9000

run-prod:
	go run main.go -p=9000 -mode=release
