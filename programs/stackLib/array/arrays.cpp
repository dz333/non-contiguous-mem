#include <stdlib.h>
#include <stdio.h>

#define PAGE_SIZE 4096
#define NUM_PTRS (PAGE_SIZE / sizeof(void*))

template <typename T>
class Array
{
private:
  void* ptable[NUM_PTRS];
  bool single;
  
public:
  Array(size_t size);
  T get(int index);
  void set(int index, T val);
};

template <typename T>
Array<T>::Array(size_t size)
{
  int numpages = ((size * sizeof(T)) / PAGE_SIZE) + 1;
  printf("Size of element is %lu\n", sizeof(T));
  printf("Num pages allocated is %d\n", numpages);
  if (numpages > 1) {
    single = false;
  } else {
    single = true;
  }
}

template <typename T>
void Array<T>::set(int index, T val)
{
  if (single) {
    T *entries = (T*) ptable;
    entries[index] = val;
  }
  return;
}

template <typename T>
T Array<T>::get(int index) {
  if (single) {
    T *entries = (T*) ptable;
    return entries[index];
  }
}

int main()
{
  Array<int> a(1000);
  a.set(0, 3);
  int x = a.get(0);
  printf("Output is %d\n", x);
}
