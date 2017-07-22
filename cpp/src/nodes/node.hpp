#ifndef NODE_H
#define NODE_H

#include <boost/algorithm/string/join.hpp>
#include <string>
#include <vector>

#include "../../lib/json.hpp"

typedef const nlohmann::json Json;

class Node {

public:
  virtual std::string to_html(Json &context) = 0;

};

typedef std::shared_ptr<Node> NodePtr;
typedef std::vector<NodePtr> NodePtrs;

#endif // NODE_H
