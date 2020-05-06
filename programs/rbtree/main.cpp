#include <cstdlib>
#include <cstdio>
#include <random>
#include <climits>
#include <iostream>
#include "Red-Black-Tree/RBTree.h"
#include "timer.h"

int main(int argc, char **argv) {
  RBTree tree;
  Timer t;
  unsigned long num_nodes = argc > 1 ? (1l << atol(argv[1])) : 0;
  int num_traversals = argc > 2 ? (atoi(argv[2])) : 0;
  std::cout << "Num Nodes: " << num_nodes << std::endl;
  /*  std::random_device rd;
  std::default_random_engine e1(rd());
  std::uniform_int_distribution<long> uniform_dist(0, LONG_MAX); */
  t.Start();
  for (unsigned long i = 0; i < num_nodes; i++) {
    tree.insertValue(i);
  }
  t.Stop();
  PrintTime("Build Time", t.Seconds());
  for (int i = 0; i < num_traversals; i++) {
    t.Start();
    tree.inorder();
    t.Stop();
    PrintTime("Traversal Time", t.Seconds());
  }
  return 0;
}
