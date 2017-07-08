#ifndef TEST_HELPER_H
#define TEST_HELPER_H

#include "catch.hpp"

#include <string>
#include <vector>

#include <boost/regex.hpp>
#include <boost/algorithm/string.hpp>
#include <boost/algorithm/string/join.hpp>

namespace TestHelper {
  std::string concat(const std::vector<std::string>);
  std::string whitespace_agnostic(std::string);
  std::string convert(bool);
}

#endif
