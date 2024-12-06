#!/bin/bash

# Set as variable
# ingress name, ingress ip
ING_NAME=ingress-ssl
ING_IP=$(kubectl get ingress $ING_NAME | tail -n +2 | awk '{print $4}')

# ingress http, https port
ING_HTTP_PORT=$(kubectl get svc ingress-nginx-controller -n ingress-nginx | tail -n +2 | awk '{print $5}' | sed -e 's/80://' -e 's/443://' -e 's;/TCP;;g' | awk -F, '{print $1}')
ING_HTTPS_PORT=$(kubectl get svc ingress-nginx-controller -n ingress-nginx | tail -n +2 | awk '{print $5}' | sed -e 's/80://' -e 's/443://' -e 's;/TCP;;g' | awk -F, '{print $2}')

# /etc/hosts
DOMAIN=https-example.foo.com
if ! egrep "$DOMAIN" /etc/hosts; then
	echo "$ING_IP $DOMAIN" >> /etc/hosts
fi

# Output command to execute
cat << EOF

== Output command to execute ==
curl -vl -k https://$DOMAIN:$ING_HTTPS_PORT
curl -k https://$DOMAIN:$ING_HTTPS_PORT
===============================
EOF
