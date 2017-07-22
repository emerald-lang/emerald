#include "attribute.hpp"

Attribute::Attribute(std::string key, NodePtr value): key(key), value(value) {}

std::string Attribute::to_html(Json &context) {
  return key + "=" + value->to_html(context);
}
