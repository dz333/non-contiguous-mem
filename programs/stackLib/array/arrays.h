#ifndef ARRAYS_H
#define ARRAYS_H
#include <stdlib.h>
#include <stdio.h>

#define PAGE_SIZE 4096
#define PTRS_PER_PAGE (PAGE_SIZE / sizeof(void*))
#define MAX_PAGES (PTRS_PER_PAGE * PTRS_PER_PAGE)
#define NUM_ELEMS (PAGE_SIZE / sizeof(T))
#define ELEMS_PER_L2 (PTRS_PER_PAGE * NUM_ELEMS)
#define single (num_data_pages == 1)
#define two_level (num_l1_pages > 1)

#define getL1Offset(i) (i / ELEMS_PER_L2)
#define getL2Index(i)  ((i / NUM_ELEMS) % PTRS_PER_PAGE)
#define getL2Offset(i) (i % NUM_ELEMS)




template <typename T>
class Array
{
private:
  void* ptable[PTRS_PER_PAGE];
  size_t num_l1_pages;
  size_t num_data_pages;
  
public:
  Array(size_t size);
  ~Array();
  T &operator[](int index);
};

template <typename T>
Array<T>::Array(size_t size)
{
  num_data_pages = (size / NUM_ELEMS)  + 1;
  num_l1_pages = (num_data_pages / PTRS_PER_PAGE) + 1;
  printf("Size of element is %lu\n", sizeof(T));
  printf("Num pages allocated is %lu\n", num_data_pages);
  printf("Number of l1 pages is %lu\n", num_l1_pages);
  if (num_data_pages > MAX_PAGES) {
    printf("Cant support that many pages!!\n");
    exit(1);
  }
  if (num_data_pages > 1) {
    if (two_level) {
      for (int i = 0; i < num_l1_pages; i++) {
	void* l1_page = malloc(PAGE_SIZE);
	ptable[i] = l1_page;
	for (int j = 0; j < PTRS_PER_PAGE; j++) {
	  void **l1_page_cast = (void **)l1_page;
	  l1_page_cast[j] = malloc(PAGE_SIZE);
	}
      }
    } else {
      for (int i = 0; i < num_data_pages; i++) {
	void* page = malloc(PAGE_SIZE);
	ptable[i] = page;
      }
    }
  }
}

template <typename T>
Array<T>::~Array() {
  if (!single) {
    if (two_level) {
      for (int i = 0; i < num_l1_pages; i++) {
	void **l1_page = (void**) ptable[i];
	for (int j = 0; j < PTRS_PER_PAGE; j++) {
	  free(l1_page[j]);
	}
	free(l1_page);
      }
    } else {
      for (int i = 0; i < num_data_pages; i++) {
	free(ptable[i]);
      }
    }
  }
}

template <typename T>
T &Array<T>::operator[](int index) {
  if (single) {
    T *entries = (T*) ptable;
    return entries[index];
  } else if (two_level) {
    T ***entries = (T***) ptable;
    int l1off = getL1Offset(index);
    T **l1_page = entries[l1off];
    int pageno = getL2Index(index);
    int offset = getL2Offset(index);
    T *page = l1_page[pageno];
    return page[offset];
  } else {
    T **entries = (T**) ptable;
    int pageno = index / NUM_ELEMS;
    int offset = index % NUM_ELEMS;
    T *page = entries[pageno];
    return page[offset];
  }
}
#endif
