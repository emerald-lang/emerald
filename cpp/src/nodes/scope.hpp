#ifndef SCOPE_H
#define SCOPE_H

#include "node.hpp"

class Scope : public Node {

public:
  Scope(NodePtr scope_fn, NodePtr body);

  std::string to_html(Json &context) override;

private:
  NodePtr scope_fn;
  NodePtr body;

};

#endif // SCOPE_H
