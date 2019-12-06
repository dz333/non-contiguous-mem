#include <cstdlib>
#include <cstdio>


int sum(int x) {
  if (x <= 1) {
    return 1;
  } else {
    return sum(x-1) + x + 1;
  }
}

int fib(int x) {
  if (x <= 1) {
    return 1;
  } else {
    return fib(x-1) + fib(x-2);
  }
}


int main(int argc, char **argv) {
  
  int n = argc > 1 ? atol(argv[1]) : 0;
  //printf("Number is: %d\n", n);
  // printf("Fib is: %d\n", fib(n));
  return sum(n);

}
  
