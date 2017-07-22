#include "node_list.hpp"

NodeList::NodeList(NodePtrs elements) : elements(elements) {}

std::string NodeList::to_html(Json &context) {
  std::vector<std::string> html_vector;
  std::transform(elements.begin(), elements.end(), html_vector.begin(), [&](NodePtr p) { return p->to_html(context); });

  return boost::algorithm::join(html_vector, "\n");
}
