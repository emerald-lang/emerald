#ifndef NODELIST_H
#define NODELIST_H

#include "node.hpp"

class NodeList : public Node {

public:
  NodeList(NodePtrs, std::string);

  std::string to_html(Json &context) override;

private:
  NodePtrs elements;
  std::string delimiter;

};

#endif // NODELIST_H
