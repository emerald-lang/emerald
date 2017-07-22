#ifndef ATTRIBUTE_H
#define ATTRIBUTE_H

#include "node.hpp"

class Attribute : public Node {
  public:
    Attribute(std::string key, NodePtr value);

    std::string to_html(Json &context) override;

  private:
    std::string key;
    NodePtr value;
};

#endif
