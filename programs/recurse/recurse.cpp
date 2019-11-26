#include <cstdlib>
#include <cstdio>
#include "../stackLib/stats/stats.h"
/*
int dynamic(int x, int y) {
  int tmp[x];
  for (int i = 0; i < x; i++) {
    tmp[i] = i * 1337 % x;
  }
  return tmp[y % x];
}
*/
int rec(int x) {
  int tmp[1000000];
  if (x < 0) {
    x = 0;
  }
  if (x <= 1) {
    int i = 0;
    while(x < 600) {
      tmp[i] = x;
      i = x;
      x += 1;
    }
    return tmp[i];
  } else {
    return rec(x - 1) + rec(x - 2);
  }
}

int main(int argc, char **argv) {
  int n = argc > 1 ? atol(argv[1]) : 0;
  printf("Number is: %d\n", n);
  //  printf("Do the thing: %d\n", dynamic(100, 11));
  printf("Rec is: %d\n", rec(n));
  return 0;
}
  
