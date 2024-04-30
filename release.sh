#!/bin/sh -ex

for arch in amd64 arm64; do

  tag="gcr.io/oden-qa/clickhouse-jdbc-bridge:$(git rev-parse --short head)-${arch}"
  docker build \
    --pull \
    --no-cache \
    --build-arg "platform=linux/${arch}" \
    --platform "linux/${arch}" \
    -f test.Dockerfile \
    -t "${tag}" \
    --push \
    .
done
