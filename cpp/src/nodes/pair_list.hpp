#ifndef PAIRLIST_H
#define PAIRLIST_H

#include "node.hpp"

class PairList : public Node {

public:
  PairList(NodePtr, NodePtrs);

  std::string to_html(Json &context) override;

private:
  NodePtr keyword;
  NodePtrs scoped_key_value_pairs;

};

#endif // PAIRLIST_H
