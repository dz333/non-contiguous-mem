#!/bin/bash

RUNS=1
if [ ! -z "$1" ]
then
    RUNS="$1"
fi
make clean && make

# echo "Running Linear Scan With Small Arrays (n=1000)"

# echo "Using default malloc"
# cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e cache-misses -e cache-references -e dTLB-load-misses -e dTLB-loads   ./scan 1000 10000000000

# echo "Using custom Arrays"
# cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e cache-misses -e cache-references -e dTLB-load-misses -e dTLB-loads  ./scan_array 1000 10000000000

# echo "Using optimized Arrays"
# cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e cache-misses -e cache-references -e dTLB-load-misses -e dTLB-loads  ./scan_opt 1000 10000000000

echo "Running Random Access With Small Arrays (n=1000)"

echo "Using default malloc"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e cache-misses -e cache-references -e dTLB-load-misses -e dTLB-loads  ./chase 1000 10000000000

echo "Using custom Arrays"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e cache-misses -e cache-references -e dTLB-load-misses -e dTLB-loads  ./chase_array 1000 10000000000

# echo "Running Linear Scan With Large Arrays (n=1000000)"

# echo "Using default malloc"
# cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e cache-misses -e cache-references -e dTLB-load-misses -e dTLB-loads  ./scan 1000000 10000000000

# echo "Using custom Arrays"
# cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e cache-misses -e cache-references -e dTLB-load-misses -e dTLB-loads  ./scan_array 1000000 10000000000

# echo "Using optimized Arrays"
# cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e cache-misses -e cache-references -e dTLB-load-misses -e dTLB-loads  ./scan_opt 1000000 10000000000

echo "Running Random Access With Large Arrays (n=1000000)"

echo "Using default malloc"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e cache-misses -e cache-references -e dTLB-load-misses -e dTLB-loads  ./chase 1000000 10000000000

echo "Using custom Arrays"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e cache-misses -e cache-references -e dTLB-load-misses -e dTLB-loads  ./chase_array 1000000 10000000000


# echo "Running Linear Scan With Large Arrays (n=1000000000)"

# echo "Using default malloc"
# cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e cache-misses -e cache-references -e dTLB-load-misses -e dTLB-loads  ./scan 1000000000 10000000000

# echo "Using custom Arrays"
# cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e cache-misses -e cache-references -e dTLB-load-misses -e dTLB-loads  ./scan_array 1000000000 10000000000

# echo "Using optimized Arrays"
# cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e cache-misses -e cache-references -e dTLB-load-misses -e dTLB-loads  ./scan_opt 1000000000 10000000000

echo "Running Random Access With Large Arrays (n=1000000000)"

echo "Using default malloc"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e cache-misses -e cache-references -e dTLB-load-misses -e dTLB-loads  ./chase 1000000000 10000000000

echo "Using custom Arrays"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e cache-misses -e cache-references -e dTLB-load-misses -e dTLB-loads  ./chase_array 1000000000 10000000000
