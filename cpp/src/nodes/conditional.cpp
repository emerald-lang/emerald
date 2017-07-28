#include "conditional.hpp"

Conditional::Conditional(bool expected, BooleanPtr condition):
  expected(expected),
  condition(condition)
{}

std::string Conditional::to_html(NodePtr body, Json &context) const {
  if (condition->truthy(context) == expected) {
    return body->to_html(context);
  } else {
    return "";
  }
}
