#ifndef BINARYEXPR_H
#define BINARYEXPR_H

#include "boolean.hpp"
#include "node.hpp"
#include <string>

class BinaryExpr : public Boolean {

public:
  enum Operator { AND, OR };
  static const std::string AND_STR;
  static const std::string OR_STR;

  BinaryExpr(BooleanPtr lhs, Operator op, BooleanPtr rhs);

  bool truthy(Json &context) const override;

private:

  BooleanPtr lhs;
  BooleanPtr rhs;
  Operator op;
};

#endif // BINARYEXPR_H
