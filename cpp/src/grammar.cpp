#include <string>
#include <regex>
#include <iostream>

#include "grammar.hpp"

/**
 * Initialize grammar for Emerald
 */
Grammar::Grammar() : emerald_parser(syntax) {

  emerald_parser["ROOT"] = [](const peg::SemanticValues& sv) -> std::string {
    return "todo: make this real output";
  };

  emerald_parser.enable_packrat_parsing();
}

/**
 * Returns initialized Emerald PEG
 */
peg::parser Grammar::get_parser() {
  return emerald_parser;
}

bool Grammar::valid(const std::string &input) {
  std::cout << input << std::endl;
  std::string output;
  emerald_parser.parse(input.c_str(), output);
  return output != "";
}
