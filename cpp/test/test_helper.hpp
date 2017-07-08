#ifndef TEST_HELPER_H
#define TEST_HELPER_H

#include "catch.hpp"

#include <string>
#include <vector>
#include <boost/algorithm/string/join.hpp>

namespace TestHelper {
  std::string concat(const std::vector<std::string> &v);
}

#endif
