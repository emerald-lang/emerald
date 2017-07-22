#ifndef TEXTLITERAL_H
#define TEXTLITERAL_H

#include "node.hpp"

class TextLiteral : public Node {

public:
  TextLiteral(NodePtrs body);

  std::string to_html(Json &context) override;

private:
  NodePtrs body;

};

#endif // TEXTLITERAL_H
