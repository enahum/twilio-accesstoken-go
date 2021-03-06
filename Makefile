.PHONY: all test clean

GOPATH ?= $(GOPATH:)
GOFLAGS ?= $(GOFLAGS:)
GO=go

TESTS=.

all: test

test: | gofmt go-test

gofmt:
	@echo GOFMT
	$(eval GOFMT_OUTPUT := $(shell gofmt -d -s access*.go grant.go jwt/ 2>&1))
	@echo "$(GOFMT_OUTPUT)"
	@if [ ! "$(GOFMT_OUTPUT)" ]; then \
		echo "gofmt sucess"; \
	else \
		echo "gofmt failure"; \
		exit 1; \
	fi

go-test:
	$(GO) test $(GOFLAGS) -run=$(TESTS) -test.v -test.timeout=20s ./jwt || exit 1
	$(GO) test $(GOFLAGS) -run=$(TESTS) -test.v -test.timeout=20s ./ || exit 1