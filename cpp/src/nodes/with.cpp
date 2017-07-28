#include "with.hpp"

With::With(std::string var_name) : var_name(var_name) {}

std::string With::to_html(NodePtr body, Json &context) const {
  Json new_context = context;
  Json &var = context[var_name];
  if (var.is_object()) {
    for (Json::const_iterator it = var.begin(); it < var.end(); ++it) {
      new_context[it.key()] = it.value();
    }
  }
  return body->to_html(new_context);
}
