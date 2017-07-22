#ifndef ESCAPED_H
#define ESCAPED_H

#include "node.hpp"

class Escaped : public Node {

public:
  Escaped(std::string content);

  std::string to_html(Json &context) override;

private:
  std::string content;

};

#endif // ESCAPED_H
