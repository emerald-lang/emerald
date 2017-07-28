#include "variable_name.hpp"

VariableName::VariableName(std::string name) : name(name) {}

std::string VariableName::to_html(Json &context) {
  if (context[name].is_primitive()) {
    return context[name];
  } else {
    return "";
  }
}

// Uses Javascript truthiness conventions
bool VariableName::truthy(Json &context) const {
  if (context[name].is_boolean()) {
    return context[name];
  } else if (context[name].is_number()) {
    return context[name] != 0;
  } else if (context[name].is_string()) {
    return !context[name].empty();
  } else if (context[name].is_object() || context[name].is_array()) {
    return true;
  } else {
    return false;
  }
}
