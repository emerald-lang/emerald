#ifndef NESTED_H
#define NESTED_H

#include "node.hpp"

class Nested : public Node {

public:
  Nested(NodePtr tag_statement, NodePtr root);

  std::string to_html(Json &context) override;

private:
  NodePtr tag_statement, root;

};

#endif // NESTED_H
