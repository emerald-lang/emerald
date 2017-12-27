#include "value_list.hpp"

ValueList::ValueList(NodePtr keyword, NodePtrs literals) : keyword(keyword), literals(literals) {}

std::string ValueList::check_keyword(NodePtr element, Json &context) {
  // TODO: figure out a 'text_value' alternative
  /**
  switch (keyword->text_value) {
  case "images":
    return "<img src=\"" + element->literal->to_html(context) + "\"/>";
    break;
  case "styles":
    return "<link rel=\"stylesheet\" href=\"" + element->literal->to_html(context) + "\"/>";
    break;
  case "scripts":
    return "<script type=\"text/javascript\" src=\"" + element->literal->to_html(context) + "\"/>";
    break;
  }
  */
  return "";
}

std::string ValueList::to_html(Json &context) {
  std::vector<std::string> html_vector;
  std::transform(literals.begin(), literals.end(), html_vector.begin(),
                 [&](NodePtr p) -> std::string { return check_keyword(p, context); });

  return boost::algorithm::join(html_vector, "\n");
}
