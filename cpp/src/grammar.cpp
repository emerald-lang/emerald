#include <string>
#include <regex>
#include <iostream>

#include "grammar.hpp"

Grammar::Grammar() : emerald_parser(syntax) {

  emerald_parser["ROOT"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      NodePtrs nodes;
      for (unsigned int i = 0; i < sv.size(); i++) nodes.push_back(sv[i].get<NodePtr>());

      return NodePtr(new Root(nodes));
    };

  emerald_parser["nested"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      NodePtr tag_statement = sv[0].get<NodePtr>();
      NodePtr root = sv[1].get<NodePtr>();

      return NodePtr(new Nested(tag_statement, root));
    };

  emerald_parser["scope"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      NodePtr scope_fn = sv[0].get<NodePtr>();
      NodePtr root = sv[1].get<NodePtr>();

      return NodePtr(new Scope(scope_fn, root));
    };

  emerald_parser["line"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      NodePtr line = sv[0].get<NodePtr>();

      return NodePtr(new Line(line));
    };

  emerald_parser["value_list"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      NodePtr keyword = sv[0].get<NodePtr>();
      NodePtrs literals = sv[1].get<NodePtrs>();

      return NodePtr(new ValueList(keyword, literals));
    };

  emerald_parser["literal_new_line"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      NodePtr inline_lit_str = sv[0].get<NodePtr>();

      return NodePtr(new LiteralNewLine(inline_lit_str));
    };

  emerald_parser["pair_list"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      NodePtr base_keyword = sv[0].get<NodePtr>();
      NodePtr attr_lit_newline = sv[1].get<NodePtr>();

      return NodePtr(new PairList(base_keyword, attr_lit_newline));
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
