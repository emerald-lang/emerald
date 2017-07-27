#include "comment.hpp"

Comment::Comment(NodePtr text_content) : text_content(text_content) {}

std::string Comment::to_html(Json &context) {
  return "<!-- " + text_content->to_html(context) + "-->\n";
}
