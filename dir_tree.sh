#!/bin/bash

set -eu

FILE="$1"
echo "strict digraph G {" > $FILE
echo "rankdir=LR;">> $FILE
find . | sed -E 's/([^/]+\/)*([^/]+\/[^/]+)$/\2/' | sed -E 's/([^/]*)(\/)?/"\1"\2/g' | sed 's|/| -> |g' | sed 's/$/;/' >> $FILE
echo "}" >> $FILE
