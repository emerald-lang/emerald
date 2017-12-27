#include "scoped_key_value_pairs.hpp"

ScopedKeyValuePairs::ScopedKeyValuePairs(std::string keyword, NodePtrs pairs) : keyword(keyword), pairs(pairs) {}

std::string ScopedKeyValuePairs::to_html(Json &context) {
  return "";
}
