#ifndef LITERALNEWLINE_H
#define LITERALNEWLINE_H

#include "node.hpp"

class LiteralNewLine : public Node {

public:
  LiteralNewLine(NodePtr line);

  std::string to_html(Json &context) override;

private:
  NodePtr inline_lit_str;

};

#endif // LITERALNEWLINE_H
