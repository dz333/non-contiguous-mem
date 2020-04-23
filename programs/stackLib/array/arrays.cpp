#include "arrays.h"
#include <assert.h>
typedef struct TestStruct_ {
  float s;          // spot price
  float v;
} TestStruct;


Array<TestStruct> *optHolder;
int main()
{
  /*
  Array<int> a(1000000);
  a[0] = 3;
  a[1] = 4;
  int x = a[0];
  printf("Output is %d\n", x);
  int* y = &a[0];
  printf("Output is %d\n", *y);
  printf("Next Output is %d\n", y[1]);
  a[1024] = 7;
  printf("Output is %d\n", a[1024]);
  a[524288] = 12;
  printf("Output is %d\n", a[524288]);
  a[999999] = -3;
  printf("Output is %d\n", a[999999]);
  int *z = &a[999999];
  printf("Addr for z is %p\n", z);
  printf("Value is %d\n",*z);
  */
  optHolder = new Array<TestStruct>(10000000);
  Array<TestStruct> opt = *optHolder;
  TestStruct zzz;
  zzz.v = 4.22f;
  TestStruct clear;
  clear.v = 0.11f;
  for (int i = 0 ; i < 10000000; i++) {
    opt[i] = zzz;
    assert(opt[i].v == zzz.v);
    assert((&opt[i])->v == zzz.v);
    opt[i] = clear;
  }
  printf("Float 0 is %f\n", opt[0].v);
  printf("addr is %p\n", &opt[0]);
  MemRegion<TestStruct> teststruct = opt.getRegion(0);
  printf("Float 0 is %f\n", teststruct.minValue->v);
  printf("Diff between min and max is %lu\n", teststruct.maxValue - teststruct.minValue);
  TestStruct* ptr = teststruct.minValue;
  int z = 0;
  while (ptr <= teststruct.maxValue) {
    assert(ptr->v == clear.v);
    z++;
    ptr++;
  }
  
  Array<int> *two = new Array<int>(1000000);
  (*two)[0] = 4;
  (*two)[1] = -1;
  ArrayIter<int>* x = new ArrayIter<int>(*two);
  printf("Val is %d\n", *(*x));
  printf("Val is %d\n", (*x)[1]);
   printf("Val is %d\n", (*x)[-1]);
  delete two;
}
