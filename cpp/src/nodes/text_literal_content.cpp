#include "text_literal_content.hpp"

TextLiteralContent::TextLiteralContent(std::string content) : content(content) {}

std::string TextLiteralContent::to_html(Json &context) {
  return content;
}
