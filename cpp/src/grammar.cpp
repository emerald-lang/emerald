#include <string>
#include <regex>
#include <iostream>

#include "grammar.hpp"

// [START] Include nodes
#include "nodes/node.hpp"
#include "nodes/node_list.hpp"
#include "nodes/boolean.hpp"
#include "nodes/scope_fn.hpp"
#include "nodes/scope.hpp"
#include "nodes/line.hpp"
#include "nodes/value_list.hpp"
#include "nodes/literal_new_line.hpp"
#include "nodes/attribute.hpp"
#include "nodes/attributes.hpp"
#include "nodes/tag_statement.hpp"
#include "nodes/text_literal_content.hpp"
#include "nodes/escaped.hpp"
#include "nodes/comment.hpp"
#include "nodes/scoped_key_value_pairs.hpp"
#include "nodes/key_value_pair.hpp"
#include "nodes/unary_expr.hpp"
#include "nodes/binary_expr.hpp"
#include "nodes/each.hpp"
#include "nodes/with.hpp"
#include "nodes/conditional.hpp"
#include "nodes/variable_name.hpp"
#include "nodes/variable.hpp"
#include "nodes/scope.hpp"
// [END] Include nodes

namespace {
  // Helper function to turn a maybe rule (one element, made optional with a ?) into its value or a default
  template<typename T>
   std::function<T(const peg::SemanticValues&)> optional(T default_value) {
    return [=](const peg::SemanticValues &sv) -> T {
      if (sv.size() > 0) {
        return sv[0].get<T>();
      } else {
        return default_value;
      }
    };
  }

  // Helper to turn plural rules (one element, repeated with + or *) into a vector of a given type
  template<typename T>
  std::function<std::vector<T>(const peg::SemanticValues&)> repeated() {
    return [](const peg::SemanticValues& sv) -> std::vector<T> {
      std::vector<T> contents;

      for (unsigned int n = 0; n < sv.size(); n++) {
        contents.push_back(sv[n].get<T>());
      }

      return contents;
    };
  }
}

Grammar::Grammar() : emerald_parser(syntax) {
  emerald_parser["ROOT"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      NodePtrs nodes = sv[0].get<NodePtrs>();
      return NodePtr(new NodeList(nodes, "\n"));
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
      NodePtrs nodes;
      std::string base_keyword = sv[0].get<std::string>();
      std::vector<const peg::SemanticValues> semantic_values = sv[1].get<std::vector<const peg::SemanticValues>>();

      std::transform(semantic_values.begin(), semantic_values.end(), nodes.begin(),
        [=](const peg::SemanticValues& svs) {
          NodePtrs pairs = svs[0].get<NodePtrs>();
          return NodePtr(new ScopedKeyValuePairs(base_keyword, pairs));
        });

      return NodePtr(new NodeList(nodes, "\n"));
    };

  emerald_parser["scoped_key_value_pairs"] = repeated<const peg::SemanticValues>();

  emerald_parser["scoped_key_value_pair"] =
    [](const peg::SemanticValues& sv) -> const peg::SemanticValues {
      return sv;
    };

  emerald_parser["key_value_pair"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      std::string key = sv[0].get<std::string>();
      NodePtr value = sv[1].get<NodePtr>();

      return NodePtr(new KeyValuePair(key, value));
    };

  emerald_parser["comment"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      NodePtr text_content = sv[0].get<NodePtr>();

      return NodePtr(new Comment(text_content));
    };

  emerald_parser["maybe_id_name"] = optional<std::string>("");

  emerald_parser["class_names"] = repeated<std::string>();

  emerald_parser["tag_statement"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      std::string tag_name = sv[0].get<std::string>();
      std::string id_name = sv[1].get<std::string>();
      std::vector<std::string> class_names = sv[2].get<std::vector<std::string>>();
      NodePtr body = sv[3].get<NodePtr>();
      NodePtr attributes = sv[4].get<NodePtr>();
      NodePtr nested = sv[5].get<NodePtr>();

      return NodePtr(
        new TagStatement(tag_name, id_name, class_names, body, attributes, nested));
    };

  emerald_parser["attr_list"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      NodePtrs nodes = sv[0].get<NodePtrs>();

      return NodePtr(new Attributes(nodes));
    };

  emerald_parser["attribute"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      std::string key = sv[0].get<std::string>();
      NodePtr value = sv[1].get<NodePtr>();
      return NodePtr(new Attribute(key, value));
    };

  emerald_parser["escaped"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      return NodePtr(new Escaped(sv.str()));
    };

  emerald_parser["maybe_negation"] = optional<bool>(false);

  emerald_parser["negation"] =
    [](const peg::SemanticValues& sv) -> bool {
      return true;
    };

  emerald_parser["unary_expr"] =
    [](const peg::SemanticValues& sv) -> BooleanPtr {
      bool negated = sv[0].get<bool>();
      BooleanPtr expr = sv[1].get<BooleanPtr>();

      return BooleanPtr(new UnaryExpr(negated, expr));
    };

  emerald_parser["binary_expr"] =
    [](const peg::SemanticValues& sv) -> BooleanPtr {
      BooleanPtr lhs = sv[0].get<BooleanPtr>();
      std::string op_str = sv[1].get<peg::SemanticValues>().str();
      BooleanPtr rhs = sv[2].get<BooleanPtr>();
      BinaryExpr::Operator op;
      if (op_str == BinaryExpr::OR_STR) {
        op = BinaryExpr::Operator::OR;
      } else if (op_str == BinaryExpr::AND_STR) {
        op = BinaryExpr::Operator::AND;
      } else {
        throw "Invalid operator: " + op_str;
      }

      return BooleanPtr(new BinaryExpr(lhs, op, rhs));
    };

  emerald_parser["boolean_expr"] =
    [](const peg::SemanticValues& sv) -> BooleanPtr {
      return sv[0].get<BooleanPtr>();
    };

  emerald_parser["maybe_key_name"] = optional<std::string>("");

  emerald_parser["each"] =
    [](const peg::SemanticValues& sv) -> ScopeFnPtr {
      std::string collection_name = sv[0].get<std::string>();
      std::string val_name = sv[1].get<std::string>();
      std::string key_name = sv[2].get<std::string>();

      return ScopeFnPtr(new Each(collection_name, val_name, key_name));
    };

  emerald_parser["with"] =
    [](const peg::SemanticValues& sv) -> ScopeFnPtr {
      std::string var_name = sv[0].get<std::string>();

      return ScopeFnPtr(new With(var_name));
    };

  emerald_parser["given"] =
    [](const peg::SemanticValues& sv) -> ScopeFnPtr {
      BooleanPtr condition = sv[0].get<BooleanPtr>();

      return ScopeFnPtr(new Conditional(true, condition));
    };

  emerald_parser["unless"] =
    [](const peg::SemanticValues& sv) -> ScopeFnPtr {
      BooleanPtr condition = sv[0].get<BooleanPtr>();

      return ScopeFnPtr(new Conditional(false, condition));
    };

  emerald_parser["scope_fn"] =
    [](const peg::SemanticValues& sv) -> ScopeFnPtr {
      return sv[0].get<ScopeFnPtr>();
    };

  emerald_parser["variable_name"] =
    [](const peg::SemanticValues& sv) -> BooleanPtr {
      std::string name = sv.str();

      return BooleanPtr(new VariableName(name));
    };

  emerald_parser["variable"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      std::string name = sv.token(0);

      return NodePtr(new Variable(name));
    };

  emerald_parser["scope"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      ScopeFnPtr scope_fn = sv[0].get<ScopeFnPtr>();
      NodePtr body = sv[1].get<NodePtr>();

      return NodePtr(new Scope(scope_fn, body));
    };

  // Repeated Nodes
  const std::vector<std::string> repeated_nodes = {
    "statements", "literal_new_lines", "key_value_pairs", "ml_lit_str_quoteds",
    "ml_templess_lit_str_qs", "inline_literals", "il_lit_str_quoteds", "attributes"
  };
  for (std::string repeated_node : repeated_nodes) {
    emerald_parser[repeated_node.c_str()] = repeated<NodePtr>();
  }

  // Wrapper Nodes
  const std::vector<std::string> wrapper_nodes = {
    "statement", "text_content", "ml_lit_str_quoted", "ml_templess_lit_str_q",
    "inline_literal", "il_lit_str_quoted", "nested_tag"
  };
  for (std::string wrapper_node : wrapper_nodes) {
    emerald_parser[wrapper_node.c_str()] =
      [](const peg::SemanticValues& sv) -> NodePtr {
        return sv[0].get<NodePtr>();
      };
  }

  // Literals
  const std::vector<std::string> literals = {
    "multiline_literal", "inline_lit_str", "inline_literals_node"
  };
  for (std::string string_rule : literals) {
    emerald_parser[string_rule.c_str()] =
      [](const peg::SemanticValues& sv) -> NodePtr {
        NodePtrs body = sv[0].get<NodePtrs>();

        return NodePtr(new NodeList(body, ""));
      };
  }

  // Literal Contents
  const std::vector<std::string> literal_contents = {
    "ml_lit_content", "il_lit_content", "il_lit_str_content"
  };
  for (std::string string_rule_content : literal_contents) {
    emerald_parser[string_rule_content.c_str()] =
      [](const peg::SemanticValues& sv) -> NodePtr {
        return NodePtr(new TextLiteralContent(sv.str()));
      };
  }

  const std::vector<std::string> optional_nodes = {
    "maybe_text_content", "maybe_nested_tag", "maybe_attr_list"
  };
  for (std::string rule_name : optional_nodes) {
    emerald_parser[rule_name.c_str()] = optional<NodePtr>(NodePtr());
  }

  // Terminals
  const std::vector<std::string> terminals = {
    "attr", "tag", "class_name", "id_name", "key_name"
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
