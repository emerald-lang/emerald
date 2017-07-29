#include "variable.hpp"

Variable::Variable(std::string name) : name(name) {}

std::string Variable::to_html(Json &context) {
  if (context[name].is_primitive()) {
    return context[name];
  } else {
    return "";
  }
}
