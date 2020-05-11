#!/bin/bash

#sizes=(93 95000 97000000 195000000 390000000)
sizes=(366048349)
for i in "${sizes[@]}"
do
    echo "Tree size is: $((44 * $i))"
#    cset shield --exec -- perf stat -r 1 -e cycles,instructions,L1-dcache-load-misses,L1-dcache-loads,dTLB-load-misses,dTLB-loads,faults,dtlb_load_misses.walk_active ./rb $i 0
    cset shield --exec -- perf stat -r 1 -e cycles,instructions,L1-dcache-load-misses,L1-dcache-loads,dTLB-load-misses,dTLB-loads,faults,dtlb_load_misses.walk_active ./rb $i 5
     echo "Now using Hugepages"
 #    LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes cset shield --exec -- perf stat -r 1 -e cycles,instructions,L1-dcache-load-misses,L1-dcache-loads,dTLB-load-misses,dTLB-loads,faults,dtlb_load_misses.walk_active ./rb $i 0
#     LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes cset shield --exec -- perf stat -r 1 -e cycles,instructions,L1-dcache-load-misses,L1-dcache-loads,dTLB-load-misses,dTLB-loads,faults,dtlb_load_misses.walk_active ./rb $i 5
done
