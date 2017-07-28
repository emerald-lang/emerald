#ifndef SCOPE_H
#define SCOPE_H

#include "node.hpp"
#include "scope_fn.hpp"

class Scope : public Node {

public:
  Scope(ScopeFnPtr scope_fn, NodePtr body);

  std::string to_html(Json &context) override;

private:
  ScopeFnPtr scope_fn;
  NodePtr body;

};

#endif // SCOPE_H
