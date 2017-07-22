#ifndef ATTRIBUTES_H
#define ATTRIBUTES_H

#include "node.hpp"

class Attributes : public Node {
  public:
    Attributes(NodePtrs attributes);

    std::string to_html(Json &context) override;

  private:
    NodePtrs attributes;
}

#endif
