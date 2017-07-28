#ifndef CONDITIONAL_H
#define CONDITIONAL_H

#include "node.hpp"
#include "scope_fn.hpp"
#include "boolean.hpp"

class Conditional : public ScopeFn {

public:
  Conditional(bool expected, BooleanPtr condition);

  std::string to_html(NodePtr body, Json &context) const override;

private:
  bool expected;
  BooleanPtr condition;

};

#endif // CONDITIONAL_H
