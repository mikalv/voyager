#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

LIB_ROOT=$(dirname "${BASH_SOURCE}")/../../../..
source "$LIB_ROOT/hack/libbuild/common/lib.sh"
source "$LIB_ROOT/hack/libbuild/common/public_image.sh"

IMG=haproxy
TAG=1.6.7-k8s-tls

build() {
	pushd $(dirname "${BASH_SOURCE}")
	gsutil cp gs://appscode-dev/binaries/reloader/0.2.6/reloader-linux-amd64 reloader
	chmod +x reloader
	local cmd="docker build -t appscode/$IMG:$TAG ."
	echo $cmd; $cmd
	rm reloader
	popd
}

binary_repo $@
