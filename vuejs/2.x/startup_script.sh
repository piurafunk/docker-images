#!/bin/ash

source ~/.ashrc

cd /code
OUTPUT=$(find . -type f -exec echo {} \;)
if [ -z "$OUTPUT" ]; then
	echo "vue init webpack ."
	vue init webpack .
	echo "npm install"
	npm install
fi	

exec npm run dev
