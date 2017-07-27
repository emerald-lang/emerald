#ifndef GRAMMAR_H
#define GRAMMAR_H

#include <string>

#include "../lib/peglib.h"

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

  const std::vector<std::string> literals = {
    "multiline_literal", "inline_literal", "inline_lit_str"
  };

  const std::vector<std::string> literal_contents = {
    "ml_lit_content", "il_lit_content", "il_lit_str_content"
  };

  const std::vector<std::string> terminals = {
    "attr", "tag", "class_name", "id_name"
  };

};

#endif // GRAMMAR_H
