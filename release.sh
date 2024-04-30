#!/bin/sh -ex

for arch in amd64 arm64; do

  docker build \
    --pull \
    --no-cache \
    --build-arg "platform=linux/${arch}" \
    --platform "linux/${arch}" \
    -f test.Dockerfile \
    -t gcr.io/oden-qa/clickhouse-jdbc-bridge:$(git rev-parse --short head)-arm64 \
    --push \
    .
done
