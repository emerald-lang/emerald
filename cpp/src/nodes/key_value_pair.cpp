#include "key_value_pair.hpp"

KeyValuePair::KeyValuePair(std::string key, NodePtr value) : key(key), value(value) {}

std::string KeyValuePair::to_html(Json &context) {
  return key + "=\"" + value->to_html(context) + "\"";
}
