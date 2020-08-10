#include <cstdlib>
#include <cstdio>
#include "../stackLib/array/arrays.h"
#include <random>
#include <sys/mman.h>
#include <unistd.h>
#include <math.h>
#ifdef DEBUG
#define DPRINT(x,y) printf(x,y);
#else
#define DPRINT(x,y)
#endif

#ifdef ARRAYOBJ
Array<int> *arr;
#endif

#define SYS_PAGE_SIZE (1 << 12)
#define PAGE_INT_OFFSET (SYS_PAGE_SIZE >> 2)

#ifndef ARRAYOBJ
int doStridedAccess(int* vals, size_t size, unsigned long iterations) {
#else
int doStridedAccess(Array<int> vals, size_t size, unsigned long iterations) {
#endif
  for (unsigned long i = 0; i < size; i++) {
    vals[i] = (i+1) * 1734;
  }
  unsigned long sum = 0;
  unsigned long innerloop = (size / PAGE_INT_OFFSET) + 1;
  unsigned long total = iterations / innerloop;
  for (unsigned long j = 0; j < total; j++) {
    for (size_t idx = 0; idx < size; idx += PAGE_INT_OFFSET) {
      sum += vals[idx];
    }
  }
  return sum;
}

int doOptStride(Array<int> vals, size_t size, unsigned long iterations) {
  for (unsigned long i = 0; i < size; i++) {
    vals[i] = (i+1) * 1734;
  }
  
  unsigned long sum = 0;
  unsigned long innerloop = (size / PAGE_INT_OFFSET) + 1;
  unsigned long total = iterations / innerloop;
  size_t pageSize = vals.getPageSize();
  for (unsigned long j = 0; j < total; j++) {
    MemRegion<int> r = vals.getRegion(0);
    while(r.pMin <= r.pMax) {
      while(r.minValue <= r.maxValue) {
	sum += *(r.minValue);
	r.minValue += PAGE_INT_OFFSET;
      }
      size_t rem = r.minValue - r.maxValue;
      r.minValue = r.pMin[1];
      r.maxValue = r.minValue + pageSize;
      r.minValue += rem;
      r.pMin++;
    }
  }
  return sum;
}

#ifndef ARRAYOBJ
int doWork(int* vals, size_t size, unsigned long iterations) {
#else
int doWork(Array<int> vals, size_t size, unsigned long iterations) {
#endif
  for (unsigned long i = 0; i < size; i++) {
    vals[i] = (i + 1) * 1734;
  }
  int sum = 0;
  std::random_device rd;
  std::default_random_engine e1(rd());
  std::uniform_int_distribution<size_t> uniform_dist(0, size - 1);
  for (unsigned long i = 0; i < iterations; i++) {
    sum += vals[uniform_dist(e1)];
  }
  return sum;
}


#ifndef ARRAYOBJ
int doScan(int* vals, size_t size, unsigned long iterations) {
#else
int doScan(Array<int> vals, size_t size, unsigned long iterations) {
#endif
  for (unsigned long i = 0; i < size; i++) {
    vals[i] = (i + 1) * 1734;
  }
  int sum = 0;
  for (unsigned long i = 0; i < iterations; i++) {
    for (size_t idx = 0; idx < size; idx++) {
      sum += vals[idx];
    }
  }
  return sum;
}
  
int doOptScan(Array<int> vals, size_t size, unsigned long iterations) {
   for (unsigned long i = 0; i < size;) {
     MemRegion<int> r = vals.getRegion(i);
     while (r.minValue <= r.maxValue) {
       *r.minValue = (i + 1) * 1734;
       r.minValue++;
       i++;
     }
  }
  int sum = 0;
  for (unsigned long i = 0; i < iterations; i++) {
    for (size_t j = 0; j < size;) {
      MemRegion<int> r = vals.getRegion(j);
      j += (r.maxValue - r.minValue) + 1;
      while(r.minValue <= r.maxValue) {
	sum += *(r.minValue);
	r.minValue++;
      }
    }
  }
  return sum;
}
 
#ifndef SCAN
 #ifdef STRIDE
  #ifdef OPT
   #define FUNC doOptStride
  #else
   #define FUNC doStridedAccess
  #endif
 #else
  #define FUNC doWork
 #endif
#else
  #ifdef OPT
    #define FUNC doOptScan
  #else
    #define FUNC doScan
  #endif
#endif
int main(int argc, char **argv) {
  unsigned long n = argc > 1 ? atol(argv[1]) : 0;
  n = 1l << n;
  unsigned long m = argc > 2 ? atol(argv[2]) : 20;
  m = 1l << m;
  DPRINT("Size of array is %lu\n",n);
  DPRINT("Numer of Accessis is %lu\n",m);
#ifndef ARRAYOBJ
  int* x = (int*) malloc(n * sizeof(int));
  int result = FUNC((int*)x, n, m);
  DPRINT("Result is %d\n", result);
  free(x);
  return result;
#else
  arr = new Array<int>(n);
  int result = FUNC(*arr, n, m);
  DPRINT("Result is %d\n", result);
  return result;
#endif
}
