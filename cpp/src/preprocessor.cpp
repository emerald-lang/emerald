#include <string>
#include <regex>
#include <iostream>

#include <boost/algorithm/string.hpp>
#include <boost/algorithm/string/replace.hpp>
#include <boost/algorithm/string/predicate.hpp>

#include "preprocessor.hpp"
#include "htmlencode.hpp"

PreProcessor::PreProcessor(const std::vector<std::string> lines) {
  in_literal = false;
  templateless_literal = false;
  current_indent = 0;
  unclosed_indents = 0;
  output = "";

  process(lines);
}

/**
 * Returns processed output
 */
std::string PreProcessor::get_output() {
  return output;
}

/**
 * Returns source map of lines to line numbers for error logging
 */
std::map<int, int> PreProcessor::get_source_map() {
  return source_map;
}

/**
 * PreProcess text before it's parsed by context-free PEG grammar
 */
void PreProcessor::process(std::vector<std::string> lines) {
  // Append newline character to the end of each line
  for (std::string &line : lines) {
    line = line + "\n";
  }

  int new_indent;

  for (int line_number = 0; line_number < lines.size(); line_number++) {
    std::string &line = lines[line_number];

    if (in_literal) {
      // To accommodate empty lines in multiline literals which are part of the literal
      // TODO: link to test case
      if (line.substr(0, line.length() - 1).empty()) {
        new_indent = current_indent;
        line = std::string(current_indent, ' ') + "\n";
      } else {
        new_indent = line.length() - boost::trim_left_copy(line).length();
      }
    } else {
      if (boost::trim_left_copy(line).empty()) continue;
      new_indent = line.length() - boost::trim_left_copy(line).length();
    }

    check_new_indent(new_indent);
    output += remove_indent_whitespace(line);
    source_map[count(output.begin(), output.end(), '\n')] = line_number+1;
    check_and_enter_literal(line);
  }
  close_tags(0);
}

/**
 * Compares the value of the new_indent with the old indentation. If the new
 * indentation is greater than the current one - open tags, else close tags
 */
void PreProcessor::check_new_indent(const int& new_indent) {
  if (new_indent > current_indent)
    open_tags(new_indent);
  else if (new_indent < current_indent)
    close_tags(new_indent);
}

/**
 *
 */
void PreProcessor::open_tags(const int& new_indent) {
  if (!in_literal) {
    output += "{\n";
    unclosed_indents++;
    current_indent = new_indent;
  }
}

/**
 *
 */
void PreProcessor::close_tags(const int& new_indent) {
  if (in_literal)
    close_literal(new_indent);
  else
    close_entered_tags(new_indent);

  current_indent = new_indent;
}

/**
 * Append closing braces if in literal and new indent is less than old one
 */
void PreProcessor::close_literal(const int& new_indent) {
  output += "$\n";
  in_literal = false;

  for (int i = 2; i < (current_indent - new_indent) / 2; i++) {
    output += "}\n";
    unclosed_indents--;
  }
}

/**
 * Append closing braces if not in literal and new indent is less than old one
 */
void PreProcessor::close_entered_tags(const int& new_indent) {
  for (int i = 1; i <= (current_indent - new_indent) / 2; i++) {
    output += "}\n";
    unclosed_indents--;
  }
}

/**
 * Crop off only Emerald indent whitespace to preserve whitespace in the
 * literal. Since $ is the end character, we need to escape it in the literal
 */
std::string PreProcessor::remove_indent_whitespace(std::string line) {
  if (in_literal) {
    std::string cropped = line.substr(current_indent);

    if (templateless_literal) {
      boost::replace_all(cropped, "\\", "\\\\");
    }

    if (!preserve_html_literal) {
      cropped = html_encode(cropped.c_str());
    }

    return boost::replace_all_copy(cropped, "$", "\\$");
  } else {
    return boost::trim_left_copy(line);
  }
}

/**
 * Checks to see if the current line is a string literal - and if so, what type
 * of literal it is
 */
void PreProcessor::check_and_enter_literal(const std::string& line) {
  if (boost::algorithm::ends_with(boost::trim_right_copy(line), "->")) {
    in_literal = true;
    current_indent += 2;
    templateless_literal = false;
    preserve_html_literal = false;
  } else if (boost::algorithm::ends_with(boost::trim_right_copy(line), "=>")) {
    in_literal = true;
    current_indent += 2;
    templateless_literal = true;
    preserve_html_literal = false;
  } else if (boost::algorithm::ends_with(boost::trim_right_copy(line), "~>")) {
    in_literal = true;
    current_indent += 2;
    templateless_literal = true;
    preserve_html_literal = true;
  }
}
