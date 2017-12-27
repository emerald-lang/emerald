#ifndef VALUELIST_H
#define VALUELIST_H

#include "node.hpp"

class ValueList : public Node {

public:
  ValueList(NodePtr keyword, NodePtrs literals);

  std::string check_keyword(NodePtr element, Json &context);
  std::string to_html(Json &context) override;

private:
  NodePtr keyword;
  NodePtrs literals;

};

#endif // VALUELIST_H
