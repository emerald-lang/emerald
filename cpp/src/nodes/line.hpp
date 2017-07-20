#ifndef LINE_H
#define LINE_H

#include "node.hpp"

class Line : public Node {

public:
  Line(NodePtr line);

  std::string to_html(Json &context) override;

private:
  NodePtr line;

};

#endif // LINE_H
