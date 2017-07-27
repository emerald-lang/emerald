#ifndef KEYVALUEPAIR_H
#define KEYVALUEPAIR_H

#include "node.hpp"

class KeyValuePair : public Node {

public:
  KeyValuePair(std::string, NodePtr);

  std::string to_html(Json &context) override;

private:
  std::string key;
  NodePtr value;

};

#endif // KEYVALUEPAIR_H
