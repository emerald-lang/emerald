#include <string>
#include <regex>
#include <iostream>

#include "preprocessor.hpp"

/**
 * Protected constructor for Singleton Design Pattern
 */
PreProcessor::PreProcessor() {
  in_literal = false;
  templateless_literal = false;
  current_indent = 0;
  unclosed_indents = 0;
  output = "";
}

/**
 * PreProcess text before it's parsed by context-free PEG grammar
 */
std::vector<std::string> PreProcessor::process(std::vector<std::string> lines) {
  int new_indent;

  for (std::string & line : lines) {
    if (in_literal) {
    } else {
    }

    check_new_indent(new_indent);
  }
}

/**
 * Compares the value of the new_indent with the old indentation. If the new
 * indentation is greater than the current one - open tags, else close tags
 */
void PreProcessor::check_new_indent(int new_indent) {
  if (new_indent > current_indent)
    open_tags(new_indent);
  else if (new_indent < current_indent)
    close_tags(new_indent);
}

/**
 *
 */
void PreProcessor::open_tags(int new_indent) {
  if (!in_literal) {
    output += "{\n";
    unclosed_indents++;
    current_indent = new_indent;
  }
}

/**
 *
 */
void PreProcessor::close_tags(int new_indent) {
  if (in_literal)
    close_literal(new_indent);
  else
    close_entered_tags(new_indent);

  current_indent = new_indent;
}

/**
 * Append closing braces if in literal and new indent is less than old one
 */
void PreProcessor::close_literal(int new_indent) {
  output += "$\n";
  in_literal = false;

}

/**
 * Append closing braces if not in literal and new indent is less than old one
 */
void PreProcessor::close_entered_tags(int new_indent) {
}

/**
 * Crop off only Emerald indent whitespace to preserve whitespace in the
 * literal. Since $ is the end character, we need to escape it in the literal.
 */
void PreProcessor::remove_indent_whitespace(std::string line) {
}

/**
 *
 */
void PreProcessor::check_and_enter_literal(std::string line) {
}
