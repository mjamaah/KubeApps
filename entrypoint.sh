#!/bin/sh

set -e

# Extract the base64 encoded config data and write this to the KUBECONFIG
echo "$INPUT_KUBE_CONFIG" | base64 --decode > /tmp/config
chmod 600 /tmp/config
export KUBECONFIG=/tmp/config

sh -c "$INPUT_ACTION $*"