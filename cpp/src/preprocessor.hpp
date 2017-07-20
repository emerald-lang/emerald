#ifndef PREPROCESSOR_H
#define PREPROCESSOR_H

#include <map>
#include <string>

/**
 * Singleton class for transforming Emerald code into intermediate
 * representation to be parsed by the PEG grammar
 */
class PreProcessor {

public:
  PreProcessor();
  std::string process(std::vector<std::string>);
  std::map<int, int> get_source_map();

private:
  void process_line_in_literal(std::string&, int&);
  void check_new_indent(const int&);
  void open_tags(const int&);
  void close_tags(const int&);
  void close_literal(const int&);
  void close_entered_tags(const int&, int = 1);
  std::string remove_indent_whitespace(std::string);
  void check_and_enter_literal(const std::string&);

  bool in_literal, templateless_literal, preserve_html_literal;
  int current_indent, unclosed_indents;
  std::string output;
  std::map<int, int> source_map;

};

#endif // PREPROCESSOR_H
