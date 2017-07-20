#include "nested.hpp"

Nested::Nested(NodePtr tag_statement, NodePtr root) : tag_statement(tag_statement), root(root) {}

std::string Nested::to_html(Json &context) {
  return tag_statement->opening_tag() + root->to_html(context) + tag_statement->closing_tag();
}
