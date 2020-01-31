#!/bin/bash


make clean && make

echo "running base test"
cset shield --exec -- perf stat -e cycles:u -e instructions:u -e cache-misses:u -e cache-references:u -e cycles:k -e instructions:k -e cache-misses:k -e cache-references:k ./fib 1000000000

make clean && make SPLIT=true

echo "running split test"

cset shield --exec -- perf stat -e cycles:u -e instructions:u -e cache-misses:u -e cache-references:u -e cycles:k -e instructions:k -e cache-misses:k -e cache-references:k ./fib 1000000000
