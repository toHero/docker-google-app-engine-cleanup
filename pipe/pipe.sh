#!/usr/bin/env bash

# Cleanup version on GCP app engine, https://cloud.google.com/appengine/
#
# Required globals:
#   KEY_FILE
#   PROJECT
#   SERVICES
#
# Optional globals:
#   DEBUG
#   KEEP_VERSIONS

source "$(dirname "$0")/common.sh"
enable_debug

# mandatory parameters
KEY_FILE=${KEY_FILE:?'KEY_FILE variable missing.'}
PROJECT=${PROJECT:?'PROJECT variable missing.'}
SERVICES=${SERVICES:?'SERVICES variable missing.'}

# Optional parameters
KEEP_VERSIONS=${KEEP_VERSIONS:='10'}

info "Setting up environment".

run 'echo "${KEY_FILE}" | base64 -d >> /tmp/key-file.json'
run gcloud auth activate-service-account --key-file /tmp/key-file.json --quiet ${gcloud_debug_args}
run gcloud config set project $PROJECT --quiet ${gcloud_debug_args}

info "Starting cleanup to GCP app engine..."

for service in $SERVICES; do
    VERSIONS=$(gcloud app versions list --service="${service}" --sort-by="~version.createTime" --filter="traffic_split = 0" --format="value(version.id)" | tail -n +${KEEP_VERSIONS})
    debug "$VERSIONS"
    if [ -z "$VERSIONS" ]
    then
        success "No version to clean"
    else
        run gcloud app versions --quiet delete ${VERSIONS} ${gcloud_debug_args}
        if [ "${status}" -eq 0 ]; then
          success "Cleanup successful."
        else
          fail "Cleanup failed."
        fi
    fi
done
