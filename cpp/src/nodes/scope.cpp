#include "scope.hpp"

Scope::Scope(NodePtr scope_fn, NodePtr body) : scope_fn(scope_fn), body(body) {}

std::string Scope::to_html(Json &context) {
  return scope_fn.to_html(body);
}
