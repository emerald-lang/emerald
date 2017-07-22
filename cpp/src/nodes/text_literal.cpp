#include "text_literal.hpp"
#include <boost/algorithm/string/join.hpp>

TextLiteral::TextLiteral(NodePtrs body) : body(body) {}

std::string TextLiteral::to_html(Json &context) {
  std::vector<std::string> converted;
  std::transform(body.begin(), body.end(), converted.begin(),
      [&](NodePtr element) -> std::string { return element->to_html(context); });
  return boost::algorithm::join(converted, "");
}
