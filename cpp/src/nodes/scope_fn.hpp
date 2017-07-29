#ifndef SCOPE_FN_H
#define SCOPE_FN_H

#include <memory>
#include "node.hpp"

class ScopeFn {
public:
  virtual std::string to_html(NodePtr body, Json &context) const = 0;
};

typedef std::shared_ptr<ScopeFn> ScopeFnPtr;
#endif
