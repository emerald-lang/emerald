#include "test_helper.hpp"

std::string TestHelper::concat(const std::vector<std::string> &v) {
  return boost::algorithm::join(v, "\n") + "\n";
}

std::string TestHelper::whitespace_agnostic(std::string input) {
  boost::regex regex_string("\\s+");
  return boost::trim(boost::regex_replace(input, regex_string, " "));
}

std::string TestHelper::convert(bool preserve_whitespace = false) {
  std::string output = ""; // TODO: change
  return preserve_whitespace ? output : whitespace_agnostic(output);
}
