#!/bin/bash

echo "Hello world"

cat << EOF > nodes.pp
node 'graylog-mongo01' {
	include '::mongodb::server'

}

node 'default' {
		notify{ 'Default node':
		}
}
EOF
