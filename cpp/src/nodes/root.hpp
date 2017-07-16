#ifndef ROOT_H
#define ROOT_H

#include "node.hpp"

class Root : public Node {
  public:
    Root(NodePtrs);

    std::string to_html(Json &context) override;

  private:
    NodePtrs elements;
};

#endif // ROOT_H
