#include <cstdlib>
#include <cstdio>
#include "../stackLib/array/arrays.h"

#ifndef ARRAYOBJ
int doWork(int* vals, int size, int iterations) {
#else
  Array<int> *arr;
int doWork(Array<int> vals, int size, int iterations) {
#endif
  for (int i = 0; i < size; i++) {
    vals[i] = (i + 1) * 1734;
  }
  int sum = 0;
  for (int i = 0; i < iterations; i++) {
    sum += vals[abs(sum % size)];
  }
  return sum;
}

int main(int argc, char **argv) {
  int n = argc > 1 ? atol(argv[1]) : 0;
  int m = argc > 2 ? atol(argv[2]) : 1000000;
#ifndef ARRAYOBJ
  int* x = (int*) malloc(n * sizeof(int));
  return doWork(x, n, m);
#else
  arr = new Array<int>(n);
  return doWork(*arr, n, m);
#endif
}

