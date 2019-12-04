#include "arrays.h"
#include <assert.h>
typedef struct OptionData_ {
  float s;          // spot price
  float strike;     // strike price
  float r;          // risk-free interest rate
  float divq;       // dividend rate
  float v;          // volatility
  float t;          // time to maturity or option expiration in years
  //     (1yr = 1.0, 6mos = 0.5, 3mos = 0.25, ..., etc)
  char OptionType;   // Option type.  "P"=PUT, "C"=CALL
  float divs;       // dividend vals (not used in this test)
  float DGrefval;   // DerivaGem Reference Value
} OptionData;


int main()
{
  /*
  Array<int> a(1000000);
  a.set(0, 3);
  a.set(1, 4);
  int x = a.get(0);
  printf("Output is %d\n", x);
  int* y = a.getAddr(0);
  printf("Output is %d\n", *y);
  printf("Next Output is %d\n", y[1]);
  a.set(1024, 7);
  printf("Output is %d\n", a.get(1024));
  a.set(524288, 12);
  printf("Output is %d\n", a.get(524288));
  a.set(999999, -3);
  printf("Output is %d\n", a.get(999999));
  int *z = a.getAddr(999999);
  printf("Addr for z is %p\n", z);
  printf("Value is %d\n",*z);
  */
  Array<OptionData> opt(10000000);
  OptionData zzz;
  zzz.v = 4.22f;
  OptionData clear;
  clear.v = 0.11f;
  for (int i = 0 ; i < 10000000; i++) {
    opt[i] = zzz;
    assert(opt[i].v == zzz.v);
    assert((&opt[i])->v == zzz.v);
    opt[i] = clear;
  }
  printf("Float 0 is %f\n", opt[0].v);
  printf("addr is %p\n", &opt[0]);

}
