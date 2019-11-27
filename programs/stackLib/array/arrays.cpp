#include <stdlib.h>
#include <stdio.h>

#define PAGE_SIZE 4096
#define NUM_PTRS (PAGE_SIZE / sizeof(void*))
#define NUM_ELEMS (PAGE_SIZE / sizeof(T))

template <typename T>
class Array
{
private:
  T* ptable[NUM_PTRS];
  bool single;
  
public:
  Array(size_t size);
  T get(int index);
  void set(int index, T val);
  T* getAddr(int index);
};

template <typename T>
Array<T>::Array(size_t size)
{
  int numpages = ((size * sizeof(T)) / PAGE_SIZE) + 1;
  printf("Size of element is %lu\n", sizeof(T));
  printf("Num pages allocated is %d\n", numpages);
  if (numpages > NUM_PTRS) {
    printf("Cant support that many pages!!\n");
    exit(1);
  }
  if (numpages > 1) {
    single = false;
    for (int i = 0; i < numpages; i++) {
      T* page = (T*) malloc(PAGE_SIZE);
      ptable[i] = page;
    }
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
  } else {
    int pageno = index / NUM_ELEMS;
    int offset = index % NUM_ELEMS;
    T *page = ptable[pageno];
    page[offset] = val;
  }
}

template <typename T>
T Array<T>::get(int index) {
  if (single) {
    T *entries = (T*) ptable;
    return entries[index];
  } else {
    int pageno = index / NUM_ELEMS;
    int offset = index % NUM_ELEMS;
    T *page = ptable[pageno];
    return page[offset];
  }
}

template <typename T>
T* Array<T>::getAddr(int index) {
  if (single) {
    T *entries = (T*) ptable;
    return &(entries[index]);
  } else {
    int pageno = index / NUM_ELEMS;
    int offset = index % NUM_ELEMS;
    return &(ptable[pageno][offset]);
  }
}

int main()
{
  Array<int> a(2000000);
  a.set(1800, 3);
  a.set(1801, 4);
  int x = a.get(1800);
  printf("Output is %d\n", x);
  int* y = a.getAddr(1800);
  printf("Output is %d\n", *y);
  printf("Next Output is %d\n", y[1]);
}
