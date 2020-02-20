#include <cstdlib>
#include <cstdio>
#include "../stackLib/array/arrays.h"

#ifdef ARRAYOBJ
Array<int> *arr;
#endif

#ifndef ARRAYOBJ
int doWork(int* vals, size_t size, unsigned long iterations) {
#else
int doWork(Array<int> vals, size_t size, unsigned long iterations) {
#endif
  for (unsigned long i = 0; i < size; i++) {
    vals[i] = (i + 1) * 1734;
  }
  int sum = 0;
  for (unsigned long i = 0; i < iterations; i++) {
    sum += vals[rand() % size];
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
  printf("Doing Opt Array Scan\n");
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
  #define FUNC doWork
#else
  #ifdef OPT
    #define FUNC doOptScan
  #else
    #define FUNC doScan
  #endif
#endif
int main(int argc, char **argv) {
  unsigned long n = argc > 1 ? atol(argv[1]) : 0;
  unsigned long m = argc > 2 ? atol(argv[2]) : 1000000;
  printf("Size of array is %lu\nNumer of Accesses is %lu\n", n, m);
#ifndef ARRAYOBJ
  int* x = (int*) malloc(n * sizeof(int));
  int result = FUNC(x, n, m);
  printf("Result is %d\n", result);
  free(x);
  return  result;
#else
  arr = new Array<int>(n);
  int result = FUNC(*arr, n, m);
  printf("Result is %d\n", result);
  return result;
#endif
}

