#!/bin/bash

# Set as variable
# ingress name, ingress ip
ING_NAME=myingress2
ING_IP=$(kubectl get ingress $ING_NAME | tail -n +2 | awk '{print $4}')

# ingress http, https port
ING_HTTP_PORT=$(kubectl get svc ingress-nginx-controller -n ingress-nginx | tail -n +2 | awk '{print $5}' | sed -e 's/80://' -e 's/443://' -e 's;/TCP;;g' | awk -F, '{print $1}')
ING_HTTPS_PORT=$(kubectl get svc ingress-nginx-controller -n ingress-nginx | tail -n +2 | awk '{print $5}' | sed -e 's/80://' -e 's/443://' -e 's;/TCP;;g' | awk -F, '{print $2}')

# /etc/hosts
if ! egrep 'foo.bar.com|bar.foo.com' /etc/hosts; then
	echo "$ING_IP foo.bar.com bar.foo.com" >> /etc/hosts
fi

# Output command to execute
cat << EOF

== Output command to execute ==
curl http://foo.bar.com:$ING_HTTP_PORT
curl http://bar.foo.com:$ING_HTTP_PORT
===============================
EOF
