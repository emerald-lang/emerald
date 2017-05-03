#include <string>
#include <regex>
#include <iostream>

#include "preprocessor.hpp"

/**
 * Protected constructor for Singleton Design Pattern
 */
PreProcessor::PreProcessor() {
  prev_indent = 0;
  unclosed_indents = 0;
}

/**
 * PreProcess text before it's parsed by context-free PEG grammar
 */
std::vector<std::string> PreProcessor::process(std::vector<std::string> lines) {

  // Add 'INDENT' and 'DEDENT' tokens based on previous indentation values
  for (int it = 0; it < lines.size(); it++) {
    std::string line = lines[it];
    std::string::size_type curr_indent = line.find_first_not_of(" \t");

    // Modify current line text based on indentation
    if (curr_indent != std::string::npos && curr_indent > prev_indent) {
      unclosed_indents++;
      lines.insert(lines.begin() + it, std::to_string(curr_indent) + " INDENT");
      it ++;
    } else if (curr_indent != std::string::npos && curr_indent < prev_indent) {
      lines.insert(lines.begin() + it, std::to_string(curr_indent) + " DEDENT");
      unclosed_indents--;
    }

    // Changes the current indent if not empty line
    if (curr_indent != std::string::npos)
      prev_indent = curr_indent;
  }

  // Close off any outstanding indents after preprocessor completes its pass
  for (int i = 0; i < unclosed_indents; i++)
    lines.push_back("0 DEDENT"); // need better alternative

  // Return vector of modified lines
  return lines;

}
