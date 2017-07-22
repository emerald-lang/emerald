#include "literal_new_line.hpp"

LiteralNewLine::LiteralNewLine(NodePtr inline_lit_str) : inline_lit_str(inline_lit_str) {}

std::string LiteralNewLine::to_html(Json &context) {
  return inline_lit_str->to_html(context);
}
