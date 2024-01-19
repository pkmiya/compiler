#!/bin/bash
make
while read -r input; do
    echo "$input"
    echo "$input" | ./main
done < test.txt