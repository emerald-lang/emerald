#ifndef TAG_STATEMENT_H
#define TAG_STATEMENT_H

#include "node.hpp"
#include <set>

class TagStatement : public Node {
public:
  TagStatement(
    std::string tag_name,
    std::string id,
    std::vector<std::string> classes,
    NodePtr body,
    NodePtr attributes,
    NodePtr nested
  );

  std::string to_html(Json &context) override;

private:
  static std::set<std::string> void_tags;

  std::string opening_tag(Json &context) const;
  std::string closing_tag() const;
  std::string id_attribute() const;
  std::string class_attribute() const;

  std::string tag_name;
  std::string id;
  std::vector<std::string> classes;
  NodePtr body;
  NodePtr attributes;
  NodePtr nested;
  bool self_closing;
};

#endif
