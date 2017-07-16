#include <string>
#include <regex>
#include <iostream>

#include "grammar.hpp"
#include "nodes/root.hpp"

Grammar::Grammar() : emerald_parser(syntax) {

  emerald_parser["ROOT"] = [](const peg::SemanticValues& sv) -> NodePtr {
    NodePtrs nodes;
    for (unsigned int i = 0; i < sv.size(); i++) nodes.push_back(sv[i].get<NodePtr>());

    return NodePtr(new Root(nodes));
  };

  emerald_parser.enable_packrat_parsing();

}

Grammar& Grammar::get_instance() {
  static Grammar instance;
  return instance;
}

peg::parser Grammar::get_parser() {
  return emerald_parser;
}

bool Grammar::valid(const std::string &input) {
  std::string output;
  emerald_parser.parse(input.c_str(), output);
  return output.length() == input.length();
}
