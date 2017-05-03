#include <string>
#include <regex>
#include <iostream>

#include "grammar.hpp"

/**
 * Initialize grammar for Emerald
 */
Grammar::Grammar() : emerald_parser(syntax) {

  emerald_parser["NUMBER"] = [](const peg::SemanticValues& sv) -> int {
    return stoi(sv.token(), nullptr, 10);
  };

  emerald_parser.enable_packrat_parsing();

}

/**
 * Returns initialized Emerald PEG
 */
peg::parser Grammar::get_parser() {
  return emerald_parser;
}
