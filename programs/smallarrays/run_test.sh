#!/bin/bash

RUNS=1
ACCESSES=33
RANDAC=$ACCESSES
STAC=$ACCESSES
SMALL=10
SMALLAC=$(($ACCESSES - $SMALL))
MID=20
MIDAC=$(($ACCESSES - $MID))
LARGE=30
LARGEAC=$(($ACCESSES - $LARGE))
HUGE=32
HUGEAC=$(($ACCESSES - $HUGE))

while getopts smlhrptgb opt; do
    case $opt in
	s) DOSMALL="true"
	   ;;
	m) DOMID="true"
	   ;;
	l) DOLARGE="true"
	   ;;
	h) DOHUGE="true"
	   ;;
	r) DORAND="true"
	   ;;
	p) DOPASS="true"
	   ;;
	t) DOSTRIDED="true"
	   ;;
	g) HUGEPGS="true"
	   ;;
	b) DOBASE="true"
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
    ACCESSES="$2"
fi
if [ ! -z "$HUGEPGS" ]
then
    export LD_PRELOAD=libhugetlbfs.so
    export HUGETLB_MORECORE=yes
fi
make clean && make

echo "$DOSMALL"
if [ ! -z "$DOSMALL" ]
then
    if [ ! -z "$DOPASS" ]
    then
	echo "Running Linear Scan With Small Arrays (n=1000)"
	
	echo "Using default malloc"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $SMALL $SMALLAC
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $SMALL $SMALLAC
	
	echo "Using optimized Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $SMALL $SMALLAC
    fi
    if [ ! -z "$DORAND" ]
    then
	echo "Running Random Access With Small Arrays (n=1000)"
    
	echo "Using default malloc"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase $SMALL $RANDAC
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase_array $SMALL $RANDAC
    fi
    if [ ! -z "$DOSTRIDED" ]
    then
	echo "Running Strided Scan With Small Arrays (n=1000)"
	
	echo "Using default malloc"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./strided $SMALL $STAC
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./strided_array $SMALL $STAC
    fi
fi

if [ ! -z "$DOMID" ]
then
    if [ ! -z "$DOPASS" ]
    then
	echo "Running Linear Scan With Medium Arrays (n=1000000)"
	
	echo "Using default malloc"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $MID $MIDAC
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $MID $MIDAC
	
	echo "Using optimized Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $MID $MIDAC
    fi
    if [ ! -z "$DORAND" ]
    then
	echo "Running Random Access With Medium Arrays (n=1000000)"
	
	echo "Using default malloc"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase $MID $RANDAC
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase_array $MID $RANDAC
    fi
    if [ ! -z "$DOSTRIDED" ]
    then
	echo "Running Strided Scan With Medium Arrays (n=1000000)"
	
	echo "Using default malloc"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./strided $MID $STAC
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./strided_array $MID $STAC
    fi
fi

if [ ! -z "$DOLARGE" ]
then
    if [ ! -z "$DOPASS" ]
    then
	echo "Running Linear Scan With Large Arrays (n=1000000000)"
	echo "Init time for default Malloc"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $LARGE 0
	
	echo "Using default malloc"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $LARGE $LARGEAC

	echo "Init time for custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $LARGE 0

	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $LARGE $LARGEAC

	echo "Init time for opt Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $LARGE 0

	echo "Using optimized Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $LARGE $LARGEAC
    fi
    if [ ! -z "$DORAND" ]
    then
	echo "Running Random Access With Large Arrays (n=1000000000)"

	echo "Init time for chase default"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase $LARGE 0

	echo "Using default malloc"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase $LARGE $RANDAC
	
	echo "Init time for chase tree"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase_array $LARGE 0
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase_array $LARGE $RANDAC
    fi
        if [ ! -z "$DOSTRIDED" ]
    then
	echo "Running Strided Scan With Large Arrays (n=1000000000)"
	
	echo "Using default malloc"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./strided $LARGE $STAC
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./strided_array $LARGE $STAC
    fi
fi

if [ ! -z "$DOHUGE" ]
then
    if [ ! -z "$DOPASS" ]
    then
	echo "Running Linear Scan With HUGE Arrays (n=10000000000)"

	echo "Init time for default Malloc"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $HUGE 0
	
	echo "Using default malloc"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $HUGE $HUGEAC
	
	echo "Init time for custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $HUGE 0
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $HUGE $HUGEAC
	
	echo "Init time for opt Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $HUGE 0
	
	echo "Using optimized Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $HUGE $HUGEAC
    fi
    if [ ! -z "$DORAND" ]
    then	
	echo "Running Random Access With Large Arrays (n=3000000000)"
	
	echo "Init time for chase default"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase $HUGE 0
	
	echo "Using default malloc"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase $HUGE $RANDAC
	
	echo "Init time for chase tree"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase_array $HUGE 0
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase_array $HUGE $RANDAC
    fi
    if [ ! -z "$DOSTRIDED" ]
    then
	echo "Running Strided Scan With HUGE Arrays (n=3000000000)"
	
	echo "Using default malloc"
	[[ "$DOBASE" ]] && LD_PRELOAD="" HUGETLB_MORECORE="" cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./strided $HUGE $STAC
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./strided_array $HUGE $STAC
    fi
fi
