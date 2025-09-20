#!/bin/sh -ex

mvn clean package

images=()

for env in qa production; do
  for arch in amd64 arm64; do
    tag="gcr.io/oden-${env}/clickhouse-jdbc-bridge:$(git rev-parse --short head)-${arch}"
    docker build \
      --pull \
      --no-cache \
      --build-arg "platform=linux/${arch}" \
      --platform "linux/${arch}" \
      -f test.Dockerfile \
      -t "${tag}" \
      --push \
      .
    images+=("${tag}")
  done
done

set +x

echo "Built images:"
echo
for img in "${images[@]}"; do
  echo "  ${img}"
done
