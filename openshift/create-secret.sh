#!/usr/bin/env sh

: ${ROLE_ARN?missing required environment variable ROLE_ARN}

cat << EOF | oc apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: cloud-credentials
  namespace: openshift-adp
stringData:
  credentials: |
    [default]
    role_arn = $ROLE_ARN
    web_identity_token_file = /var/run/secrets/openshift/serviceaccount/token
EOF
