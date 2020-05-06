#!/bin/bash

for i in {28..28}
do
    echo "Tree size is: $((44 * $((1 << $i))))"
    cset shield --exec -- perf stat -r 1 -e cycles,instructions,L1-dcache-load-misses,L1-dcache-loads,dTLB-load-misses,dTLB-loads,faults,dtlb_load_misses.walk_active ./rb $i 0
    cset shield --exec -- perf stat -r 1 -e cycles,instructions,L1-dcache-load-misses,L1-dcache-loads,dTLB-load-misses,dTLB-loads,faults,dtlb_load_misses.walk_active ./rb $i 5
    echo "Now using Hugepages"
    LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes cset shield --exec -- perf stat -r 1 -e cycles,instructions,L1-dcache-load-misses,L1-dcache-loads,dTLB-load-misses,dTLB-loads,faults,dtlb_load_misses.walk_active ./rb $i 0
    LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes cset shield --exec -- perf stat -r 1 -e cycles,instructions,L1-dcache-load-misses,L1-dcache-loads,dTLB-load-misses,dTLB-loads,faults,dtlb_load_misses.walk_active ./rb $i 5
done
