#include "literal_new_line.hpp"

LiteralNewLine::LiteralNewLine(NodePtr literal_new_line) : literal_new_line(literal_new_line) {}

std::string LiteralNewLine::to_html(Json &context) {
  return literal_new_line->to_html(context);
}
