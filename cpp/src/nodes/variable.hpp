#ifndef VARIABLE_H
#define VARIABLE_H

#include "node.hpp"

class Variable : public Node {

public:
  Variable(std::string name);

  std::string to_html(Json &context) override;

private:
  std::string name;

};

#endif // VARIABLE_H
