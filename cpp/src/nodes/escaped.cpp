#include "escaped.hpp"

Escaped::Escaped(std::string content) : content(content) {}

std::string Escaped::to_html(Json &context) {
  // Unescape the string
  return content.substr(1);
}
