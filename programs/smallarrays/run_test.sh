#!/bin/bash

RUNS=1
ITERATIONS=10
sizes=()
DOTREE="true"
while getopts smlhptgb opt; do
    case $opt in
	s) sizes+=(10)
	   ;;
	m) sizes+=(20)
	   ;;
	l) sizes+=(30)
	   ;;
	h) sizes+=(31 32 33 34)
	   ;;
	p) DOPASS="true"
	   ;;
	t) DOSTRIDED="true"
	   ;;
	g) HUGEPGS="true"
	   ;;
	b) DOBASE="true"
	   DOTREE=""
	   ;;
    esac
done
shift "$((OPTIND-1))"

if [ ! -z "$1" ]
then
    RUNS="$1"
fi
if [ ! -z "$2" ]
then
    ITERATIONS="$2"
fi
if [ ! -z "$HUGEPGS" ]
then
    export LD_PRELOAD=libhugetlbfs.so
    export HUGETLB_MORECORE=yes
fi
make clean && make

echo "${sizes[@]}"
for s in "${sizes[@]}"
do
    
    ACCESSES=$ITERATIONS
    echo "num accesses = $(($((1 << $s)) * $ACCESSES))"
    if [ ! -z "$DOPASS" ]
    then
	echo "Running Linear Scan With Size=$s)"
	echo "Init time for default Malloc"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $s 0
	echo "Using default malloc"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $s $ACCESSES
	echo "Init time for custom Arrays"
	[[ "$DOTREE" ]] && cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $s 0
	echo "Using custom Trees"
	[[ "$DOTREE" ]] && cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $s $ACCESSES	
	echo "Init time for opt Trees"
	[[ "$DOTREE" ]] && cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $s 0
	echo "Using optimized Trees"
	[[ "$DOTREE" ]] && cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $s $ACCESSES
    fi    
    if [ ! -z "$DOSTRIDED" ]
    then
	echo "Running Strided Scan With Size=$s"
	echo "Using default malloc"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./strided $s $ACCESSES
	echo "Using custom Arrays"
	[[ "$DOTREE" ]] && cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./strided_array $s $ACCESSES
    fi
done
