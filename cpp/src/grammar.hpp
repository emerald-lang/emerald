#ifndef GRAMMAR_H
#define GRAMMAR_H

#include <string>

#include "../lib/peglib.h"

#include "nodes/node.hpp"

/**
 * Singleton class for transforming Emerald code into intermediate
 * representation to be parsed by the PEG grammar
 */
class Grammar {

public:
  Grammar(Grammar const&)            = delete; // Copy constructor
  Grammar& operator=(Grammar const&) = delete; // Copy assignment
  Grammar(Grammar&&)                 = delete; // Move constructor
  Grammar& operator=(Grammar&&)      = delete; // Move assignment

  static Grammar& get_instance();
  peg::parser get_parser();
  bool valid(const std::string &input);

protected:
  Grammar();

private:
  std::string get_whitespace(int);

  // PEG parser
  peg::parser emerald_parser;

  // Grammar rules
  static constexpr const auto syntax =
    #include "grammar.peg"
      "\n"
    #include "tokens.peg"
      "\n"
    #include "scopes.peg"
      "\n"
    #include "variables.peg"
      "\n"
    R"(%whitespace        <- [ \t]*)"
  ;

};

#endif // GRAMMAR_H
