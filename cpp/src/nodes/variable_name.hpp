#ifndef VARIABLENAME_H
#define VARIABLENAME_H

#include "node.hpp"
#include "boolean.hpp"

class VariableName : public Node, public Boolean {

public:
  VariableName(std::string name);

  std::string to_html(Json &context) override;

  bool truthy(Json &context) const override;

private:
  std::string name;

};

#endif // VARIABLENAME_H
