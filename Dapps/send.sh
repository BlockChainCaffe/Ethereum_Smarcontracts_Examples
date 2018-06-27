#!/bin/bash

FROM=$1
VALUE=$2

NONCE=$(./gettrcount.sh $FROM)
TR=$(python3 sign.py $VALUE $NONCE)

curl -X POST --data '{"jsonrpc":"2.0","method":"eth_sendRawTransaction","params":["'$TR'"],"id":1}' https://ropsten.infura.io/ZwIpa5uHKUa6OCRfOm4q
