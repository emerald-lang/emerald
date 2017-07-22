#include <string>
#include <regex>
#include <iostream>

#include "grammar.hpp"

// [START] Include nodes
#include "nodes/node.hpp"
#include "nodes/root.hpp"
#include "nodes/nested.hpp"
#include "nodes/scope.hpp"
#include "nodes/line.hpp"
#include "nodes/value_list.hpp"
#include "nodes/literal_new_line.hpp"
#include "nodes/attribute.hpp"
#include "nodes/attributes.hpp"
#include "nodes/tag_statement.hpp"
#include "nodes/text_literal.hpp"
#include "nodes/text_literal_content.hpp"
#include "nodes/escaped.hpp"
// [END] Include nodes

namespace {
  // Helper function to check if the optional (?) ith token in a rule
  // matched anything
  bool present(const peg::SemanticValues& sv, size_t i) {
    return !sv.token(i).empty();
  }

  // Helper to turn the repeated (+ or *) ith token into a vector of
  // a given type
  template<typename T>
  std::vector<T> repeated(const peg::SemanticValues& sv, size_t i) {
    std::vector<T> contents;
    const peg::SemanticValues repeated_node = sv[i].get<peg::SemanticValues>();
    for (unsigned int n = 0; n < repeated_node.size(); n++) {
      contents.push_back(repeated_node[n].get<T>());
    }
    return contents;
  }
}

Grammar::Grammar() : emerald_parser(syntax) {
  emerald_parser["ROOT"] = [](const peg::SemanticValues& sv) -> NodePtr {
      NodePtrs nodes = repeated<NodePtr>(sv, 0);
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

  emerald_parser["tag_statement"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      std::string tag_name = sv[0].get<std::string>();
      std::string id_name = present(sv, 1) ? sv[1].get<std::string>() : "";
      std::vector<std::string> class_names = repeated<std::string>(sv, 2);
      NodePtr body = present(sv, 3) ? sv[3].get<NodePtr>() : NodePtr();
      NodePtr attributes = present(sv, 4) ? sv[4].get<NodePtr>() : NodePtr();

      return NodePtr(new TagStatement(tag_name, id_name, class_names, body, attributes));
    };

  emerald_parser["attributes"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      NodePtrs nodes;
      const peg::SemanticValues &content = sv[0].get<peg::SemanticValues>();
      for (unsigned int i = 0; i < content.size(); i++) nodes.push_back(content[i].get<NodePtr>());

      return NodePtr(new Attributes(nodes));
    };

  emerald_parser["attribute"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      std::string key = sv[0].get<std::string>();
      NodePtr value = sv[1].get<NodePtr>();
      return NodePtr(new Attribute(key, value));
    };

  std::vector<std::string> literals = {
    "multiline_literal", "inline_literal", "inline_lit_str"
  };
  for (std::string string_rule : literals) {
    emerald_parser[string_rule.c_str()] =
      [](const peg::SemanticValues& sv) -> NodePtr {
        NodePtrs body = repeated<NodePtr>(sv, 0);

        return NodePtr(new TextLiteral(body));
      };
  }

  std::vector<std::string> literal_contents = {
    "ml_lit_content", "il_lit_content", "il_lit_str_content"
  };
  for (std::string string_rule_content : literal_contents) {
    emerald_parser[string_rule_content.c_str()] =
      [](const peg::SemanticValues& sv) -> NodePtr {
        return NodePtr(new TextLiteralContent(sv.str()));
      };
  }

  emerald_parser["escaped"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      return NodePtr(new Escaped(sv.str()));
    };

  emerald_parser["text_content"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      return sv[0].get<NodePtr>();
    };

  // Terminals

  std::vector<std::string> terminals = {
    "attr",
    "tag",
    "class_name",
    "id_name"
  };
  for (std::string rule_name : terminals) {
    emerald_parser[rule_name.c_str()] =
      [](const peg::SemanticValues& sv) -> std::string {
        return sv.str();
      };
  }

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
