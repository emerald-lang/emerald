#include "tag_statement.hpp"
#include <boost/algorithm/string/join.hpp>

TagStatement::TagStatement(
  std::string tag_name,
  std::string id,
  std::vector<std::string> classes,
  NodePtr body,
  NodePtr attributes,
  NodePtr nested
):
  tag_name(tag_name),
  id(id),
  classes(classes),
  body(body),
  attributes(attributes),
  nested(nested),
  self_closing(void_tags.find(tag_name) != void_tags.end())
{}

std::set<std::string> TagStatement::void_tags = {
  "area", "base", "br", "col", "embed", "hr", "img",
  "input", "link", "menuitem", "meta", "param", "source",
  "track", "wbr"
};

std::string TagStatement::to_html(Json &context) {
  if (self_closing) {
    return opening_tag(context);
  } else if (body) {
    return opening_tag(context) + body->to_html(context) + closing_tag();
  } else {
    return opening_tag(context) + nested->to_html(context) + closing_tag();
  }
}

std::string TagStatement::opening_tag(Json &context) const {
  return "<" + tag_name + id_attribute() + class_attribute() +
    (attributes ? " " + attributes->to_html(context) : "") +
    (self_closing ? " />" : ">");
}

std::string TagStatement::id_attribute() const {
  if (id.empty()) {
    return "";
  } else {
    return " id=\"" + id + "\"";
  }
}

std::string TagStatement::class_attribute() const {
  if (classes.size() == 0) {
    return "";
  } else {
    return " class=\"" + boost::algorithm::join(classes, " ") + "\"";
  }
}

std::string TagStatement::closing_tag() const {
  return "</" + tag_name + ">";
}
