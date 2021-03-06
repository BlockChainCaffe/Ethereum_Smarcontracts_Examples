#!/bin/bash

FROM=$(cat config.py | grep myaddress | grep -v "^#" | sed "s:\"$::" | sed "s:^.*\"::")
VALUE=$1

NONCE=$(./gettrcount.sh $FROM)
TR=$(python3 send.py $VALUE $NONCE)

curl -X POST --data '{"jsonrpc":"2.0","method":"eth_sendRawTransaction","params":["'$TR'"],"id":1}' https://ropsten.infura.io/ZwIpa5uHKUa6OCRfOm4q
