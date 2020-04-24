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
  teststruct = opt.getRegion(10000000);
  printf("Last region val is %p\n", teststruct.minValue);
  teststruct = opt.getRegion( 9999999);
  printf("Last region val is %p\n", teststruct.minValue);
  TestStruct* ptr = teststruct.minValue;
  int z = 0;
  while (ptr <= teststruct.maxValue) {
    assert(ptr->v == clear.v);
    z++;
    ptr++;
  }
  
  Array<int> *two = new Array<int>(1000000);
  (*two)[0] = 4;
  (*two)[1] = -7;
  (*two)[2] = 1337;
  (*two)[3] = 4444;
  ArrayIter<int> test = ArrayIter<int>(two);
  ArrayIter<int> other = ArrayIter<int>(test);
  printf("Val is %d\n", *(test));
  printf("Val is %d\n", (test)[1]);
  ++test;
  test++;
  printf("Val is %d\n", *(test));
  printf("Val is %d\n", (test)[-1]);
  --test;
  test--;
  printf("Val is %d\n", *(test));
  printf("Val is %d\n", (test)[1]);
  test += 2;
  printf("Val is %d\n", *(test));
  printf("Val is %d\n", (test)[1]);
  test += -2;
  printf("Val is %d\n", *(test));
  printf("Val is %d\n", (test)[1]);
  test -= -2;
  printf("Val is %d\n", *(test));
  printf("Val is %d\n", (test)[1]);
  printf("Test == other is %d and test[0] = other[0] is %d\n", test == other, test[0] == other[0]);
  test -= 2;
  printf("Val is %d\n", *(test));
  printf("Val is %d\n", (test)[1]);
  printf("Test == other is %d and test[0] = other[0] is %d\n", test == other, test[0] == other[0]);
  ArrayIter<int> y = test;
  printf("Val is %d\n", *y);
  printf("Val is %d\n", y[1]);
  printf("Test == y is %d and test[0] = other[0] is %d\n", test == y, test[0] == y[0]);
  y = test + 2;
  printf("Val is %d\n", *y);
  printf("Val is %d\n", y[1]);
  printf("Test == y is %d and test[0] = other[0] is %d\n", test == y, test[0] == y[0]);
  swap(y, test);
  printf("Val is %d\n", *y);
  printf("Val is %d\n", y[1]);
  printf("y - test is %ld\n", y - test);
  printf("test - y is %ld\n", test - y);
  delete two;
}
