#ifndef LINE_H
#define LINE_H

#include "node.hpp"

class LiteralNewLine : public Node {

public:
  LiteralNewLine(NodePtr line);

  std::string to_html(Json &context) override;

private:
  NodePtr inline_lit_str;

};

#endif // LINE_H
