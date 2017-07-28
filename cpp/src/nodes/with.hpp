#ifndef WITH_H
#define WITH_H

#include "scope_fn.hpp"

class With : public ScopeFn {

public:
  With(std::string var_name);

  std::string to_html(NodePtr body, Json &context) const override;

private:
  std::string var_name;

};

#endif // WITH_H
