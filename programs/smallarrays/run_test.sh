!/bin/bash

RUNS=1
ACCESSES=10000000000
if [ ! -z "$1" ]
then
    RUNS="$1"
fi
if [ ! -z "$2" ]
then
    ACCESSES="$2"
fi
RANDAC=$(($ACCESSES / 100))
SMALL=1000
MID=1000000
LARGE=1000000000

make clean && make

echo "Running Linea# r Scan With Small Arrays (n=1000)"

echo "Using default malloc"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $SMALL $(($ACCESSES / $SMALL))

echo "Using custom Arrays"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $SMALL $(($ACCESSES / $SMALL))

echo "Using optimized Arrays"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $SMALL $(($ACCESSES / $SMALL))

 echo "Running Random Access With Small Arrays (n=1000)"

echo "Using default malloc"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase $SMALL $RANDAC

echo "Using custom Arrays"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase_array $SMALL $RANDAC

echo "Running Linear Scan With Large Arrays (n=1000000)"

echo "Using default malloc"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $MID $(($ACCESSES / $MID))

echo "Using custom Arrays"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $MID $(($ACCESSES / $MID))

echo "Using optimized Arrays"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $MID $(($ACCESSES / $MID))

echo "Running Random Access With Medium Arrays (n=1000000)"

echo "Using default malloc"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase $MID $RANDAC

echo "Using custom Arrays"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase_array $MID $RANDAC


echo "Running Linear Scan With Large Arrays (n=1000000000)"

echo "Using default malloc"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $LARGE $(($ACCESSES / $LARGE))

echo "Using custom Arrays"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $LARGE $(($ACCESSES / $LARGE))

echo "Using optimized Arrays"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $LARGE $(($ACCESSES / $LARGE))

echo "Running Random Access With Large Arrays (n=1000000000)"

echo "Using default malloc"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase $LARGE $RANDAC

echo "Using custom Arrays"
cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase_array $LARGE $RANDAC
