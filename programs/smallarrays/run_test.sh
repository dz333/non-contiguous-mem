#!/bin/bash

RUNS=1
ACCESSES=10000000000
RANDAC=$ACCESSES
SMALL=1000
MID=1000000
LARGE=1000000000
HUGE=3000000000

while getopts smlhrp opt; do
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

echo "$DOSMALL"
if [ ! -z "$DOSMALL" ]
then
    if [ ! -z "$DOPASS" ]
    then
	echo "Running Linear Scan With Small Arrays (n=1000)"
	
	echo "Using default malloc"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $SMALL $(($ACCESSES / $SMALL))
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $SMALL $(($ACCESSES / $SMALL))
	
	echo "Using optimized Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $SMALL $(($ACCESSES / $SMALL))
    fi
    if [ ! -z "$DORAND" ]
    then
	echo "Running Random Access With Small Arrays (n=1000)"
    
	echo "Using default malloc"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase $SMALL $RANDAC
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase_array $SMALL $RANDAC
    fi
fi

if [ ! -z "$DOMID" ]
then
    if [ ! -z "$DOPASS" ]
    then
	echo "Running Linear Scan With Medium Arrays (n=1000000)"
	
	echo "Using default malloc"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $MID $(($ACCESSES / $MID))
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $MID $(($ACCESSES / $MID))
	
	echo "Using optimized Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $MID $(($ACCESSES / $MID))
    fi
    if [ ! -z "$DORAND" ]
    then
	echo "Running Random Access With Medium Arrays (n=1000000)"
	
	echo "Using default malloc"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase $MID $RANDAC
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase_array $MID $RANDAC
    fi
fi

if [ ! -z "$DOLARGE" ]
then
    if [ ! -z "$DOPASS" ]
    then
	echo "Running Linear Scan With Large Arrays (n=1000000000)"
	echo "Init time for default Malloc"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $LARGE 0
	
	echo "Using default malloc"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $LARGE $(($ACCESSES / $LARGE))

	echo "Init time for custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $LARGE 0

	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $LARGE $(($ACCESSES / $LARGE))

	echo "Init time for opt Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $LARGE 0

	echo "Using optimized Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $LARGE $(($ACCESSES / $LARGE))
    fi
    if [ ! -z "$DORAND" ]
    then
	echo "Running Random Access With Large Arrays (n=1000000000)"

	echo "Init time for chase default"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase $LARGE 0

	echo "Using default malloc"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase $LARGE $RANDAC
	
	echo "Init time for chase tree"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase_array $LARGE 0
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase_array $LARGE $RANDAC
    fi
fi

if [ ! -z "$DOHUGE" ]
then
    if [ ! -z "$DOPASS" ]
    then
	echo "Running Linear Scan With HUGE Arrays (n=10000000000)"

	echo "Init time for default Malloc"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $HUGE 0
	
	echo "Using default malloc"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan $HUGE $(($ACCESSES / $HUGE))
	
	echo "Init time for custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $HUGE 0
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_array $HUGE $(($ACCESSES / $HUGE))
	
	echo "Init time for opt Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $HUGE 0
	
	echo "Using optimized Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./scan_opt $HUGE $(($ACCESSES / $HUGE))
    fi
    if [ ! -z "$DORAND" ]
    then	
	echo "Running Random Access With Large Arrays (n=1000000000)"
	
	echo "Init time for chase default"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase $HUGE 0
	
	echo "Using default malloc"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase $HUGE $RANDAC
	
	echo "Init time for chase tree"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase_array $HUGE 0
	
	echo "Using custom Arrays"
	cset shield --exec -- perf stat -r "$RUNS" -e cycles -e instructions -e L1-dcache-load-misses -e L1-dcache-loads -e dTLB-load-misses -e dTLB-loads  ./chase_array $HUGE $RANDAC
    fi
fi
