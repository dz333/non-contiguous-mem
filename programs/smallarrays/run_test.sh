#!/bin/bash


make clean && make

echo "Running Linear Scan With Small Arrays (n=1000)"

echo "Using default malloc"
cset shield --exec -- perf stat -r 10 -e cycles -e instructions -e cache-misses -e cache-references ./scan 1000 10000000000

echo "Using custom Arrays"
cset shield --exec -- perf stat -r 10 -e cycles -e instructions -e cache-misses -e cache-references ./scan_array 1000 10000000000

echo "Running Pointer Chase With Small Arrays (n=1000)"

echo "Using default malloc"
cset shield --exec -- perf stat -r 10 -e cycles -e instructions -e cache-misses -e cache-references ./chase 1000 10000000000

echo "Using custom Arrays"
cset shield --exec -- perf stat -r 10 -e cycles -e instructions -e cache-misses -e cache-references ./chase_array 1000 10000000000



echo "Running Linear Scan With Large Arrays (n=1000000)"

echo "Using default malloc"
cset shield --exec -- perf stat -r 10 -e cycles -e instructions -e cache-misses -e cache-references ./scan 1000000 10000000000

echo "Using custom Arrays"
cset shield --exec -- perf stat -r 10 -e cycles -e instructions -e cache-misses -e cache-references ./scan_array 1000000 10000000000

echo "Running Pointer Chase With Large Arrays (n=1000000)"

echo "Using default malloc"
cset shield --exec -- perf stat -r 10 -e cycles -e instructions -e cache-misses -e cache-references ./chase 1000000 10000000000

echo "Using custom Arrays"
cset shield --exec -- perf stat -r 10 -e cycles -e instructions -e cache-misses -e cache-references ./chase_array 1000000 10000000000
