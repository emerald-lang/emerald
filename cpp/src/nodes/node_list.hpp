#ifndef NODELIST_H
#define NODELIST_H

#include "node.hpp"

class NodeList : public Node {

public:
  NodeList(NodePtrs);

  std::string to_html(Json &context) override;

private:
  NodePtrs elements;

};

#endif // NODELIST_H
