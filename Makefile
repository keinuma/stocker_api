BRANCH = $(shell git rev-parse --abbrev-ref HEAD | perl -pe "s/[^A-Za-z0-9\n]/-/g;" | cut -c 1-64)
VERSION = $(shell git describe --tags --always --abbrev=0 --match='v[0-9]*.[0-9]*.[0-9]*' 2> /dev/null | sed 's/^.//')
PACKAGE_NAME = github.com/keinuma/stocker-api

GOBIN := ${CURDIR}/bin

.DEFAULT_GOAL := help
.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z\/_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: download
download: ## Run go mod download
	go mod download

.PHONY: run
run: ## Run go run main.go
	go run ./app/cmd/api/main.go
