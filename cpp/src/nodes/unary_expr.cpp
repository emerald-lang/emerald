#include "unary_expr.hpp"

UnaryExpr::UnaryExpr(bool negated, BooleanPtr expr) : negated(negated), expr(expr) {}

bool UnaryExpr::truthy(Json &context) const {
  if (negated) {
    return !expr->truthy(context);
  } else {
    return expr->truthy(context);
  }
}
