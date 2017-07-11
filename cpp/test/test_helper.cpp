#include "test_helper.hpp"

std::string TestHelper::concat(std::vector<std::string> v) {
  return boost::algorithm::join(v, "\n") + "\n";
}

std::string TestHelper::whitespace_agnostic(std::string input) {
  boost::regex regex_string("\\s+");
  return boost::trim_copy(boost::regex_replace(input, regex_string, " "));
}

std::string TestHelper::convert(const std::vector<std::string> input,
                                json context, bool preserve_whitespace) {
  std::string input_str = concat(input);
  std::string output = "test"; // TODO: change to process emerald
  return preserve_whitespace ? output : whitespace_agnostic(output);
}
