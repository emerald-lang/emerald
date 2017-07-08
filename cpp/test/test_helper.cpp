#include "test_helper.hpp"

std::string TestHelper::concat(const std::vector<std::string> &v) {
  return boost::algorithm::join(v, "\n") + "\n";
}
