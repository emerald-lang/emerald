#include "root.hpp"

Root::Root(NodePtrs elements) : elements(elements) {}

std::string Root::to_html(Json &context) {
  std::vector<std::string> html_vector;
  std::transform(elements.begin(), elements.end(), html_vector.begin(), [&](NodePtr p) { return p->to_html(context); });

  return boost::algorithm::join(html_vector, "\n");
}
