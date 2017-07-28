#ifndef UNARYEXPR_H
#define UNARYEXPR_H

#include "boolean.hpp"
#include "node.hpp";

class UnaryExpr : public Boolean {

public:
  UnaryExpr(bool negated, BooleanPtr expr);

  bool truthy(Json &context) const override;

private:
  bool negated;
  BooleanPtr expr;
};

#endif // UNARYEXPR_H
