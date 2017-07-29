#include "binary_expr.hpp"

const std::string BinaryExpr::AND_STR = "and";
const std::string BinaryExpr::OR_STR = "or";

BinaryExpr::BinaryExpr(BooleanPtr lhs, Operator op, BooleanPtr rhs):
  lhs(lhs),
  op(op),
  rhs(rhs)
{}

bool BinaryExpr::truthy(Json &context) const {
  switch (op) {
    case AND:
      return lhs->truthy(context) && rhs->truthy(context);
    case OR:
      return lhs->truthy(context) || rhs->truthy(context);
  }
}
