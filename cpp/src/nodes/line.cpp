#include "line.hpp"

Line::Line(NodePtr line) : line(line) {}

std::string Line::to_html(Json &context) {
  return line->to_html(context);
}
