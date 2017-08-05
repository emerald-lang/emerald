#include "node_list.hpp"

NodeList::NodeList(NodePtrs elements, std::string delimiter) : elements(elements), delimiter(delimiter) {}

std::string NodeList::to_html(Json &context) {
  std::vector<std::string> html_vector;
  std::transform(elements.begin(), elements.end(), html_vector.begin(),
    [&](NodePtr element) { return element->to_html(context); });

  return boost::algorithm::join(html_vector, delimiter);
}
