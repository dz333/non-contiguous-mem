# non-contiguous-mem
A repo for measuring performance assuming noncontiguous memory allocation


## TODOS

Instrument stack frame allocation code to track:
 - number of dynamically required allocations (how often do we not have enough space)
   vs. total number of function calls
 - size of allocations (histogram) -> this can often be statically analyzed

Instrument `alloca` and `malloc` calls to determine how often (both statically and dynamically)
we allocate objects greater than 4KB.

Rewrite some C benchmark to use a page-table like datastructure instead of large dynamic allocations.
 - Need to *pick* a benchmark based on results of instrumentation (i.e. it actually does large dynamic allocations)
 - Need to actually implement the datastructure fo allocation.

