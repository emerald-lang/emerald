#ifndef BOOLEAN_H
#define BOOLEAN_H

#include <memory>
#include "node.hpp"

class Boolean {
public:
  virtual bool truthy(Json &context) const = 0;
};

typedef std::shared_ptr<Boolean> BooleanPtr;
#endif
