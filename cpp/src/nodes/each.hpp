#ifndef EACH_H
#define EACH_H

#include "scope_fn.hpp"
#include "node.hpp"
#include <string>

class Each : public ScopeFn {

public:
  Each(std::string collection_name, std::string val_name, std::string key_name);

  std::string to_html(NodePtr body, Json &context) const override;

private:
  std::string collection_name;
  std::string val_name;
  std::string key_name;
};

#endif // EACH_H
