#!/usr/bin/env bash

set -e

API_URL="https://api.porkbun.com"
DOMAIN="reynn.dev"
CERTS_DIR="overlays/secrets/ssl"

if [[ -z "$PORKBUN_SECRET_KEY" ]]; then
  echo "'PORKBUN_SECRET_KEY' not set"
  exit 1
fi
if [[ -z "$PORKBUN_API_KEY" ]]; then
  echo "'PORKBUN_API_KEY' not set"
  exit 1
fi

DOMAIN_CERT_RESPONSE=$(curl --silent -X POST \
  -d "{\"secretapikey\":\"$PORKBUN_SECRET_KEY\",\"apikey\":\"$PORKBUN_API_KEY\"}" \
  "$API_URL/api/json/v3/ssl/retrieve/$DOMAIN")

mkdir -p $CERTS_DIR
echo "$DOMAIN_CERT_RESPONSE" | jq -r '"\(.certificatechain)\n\n\(.publickey)"' > $CERTS_DIR/domain.cert.pem
echo "$DOMAIN_CERT_RESPONSE" | jq -r .privatekey > $CERTS_DIR/private.key.pem
echo "--- certs updated ---"
