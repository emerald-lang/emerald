#include "attributes.hpp"

Attributes::Attributes(NodePtrs attributes): attributes(attributes) {}

std::string Attributes::to_html(Json &context) {
  std::vector<std::string> converted;
  std::transform(attributes.begin(), attributes.end(), converted.begin(), [&](NodePtr p) {
    return p->to_html(context);
  });

  return boost::algorithm::join(converted, " ");
}
