#ifndef PREPROCESSOR_H
#define PREPROCESSOR_H

#include <string>

/**
 * Singleton class for transforming Emerald code into intermediate
 * representation to be parsed by the PEG grammar
 */
class PreProcessor {

public:
  static PreProcessor& get_instance() {
    static PreProcessor instance;
    return instance;
  }

  PreProcessor(PreProcessor const&)            = delete; // Copy constructor
  PreProcessor& operator=(PreProcessor const&) = delete; // Copy assignment
  PreProcessor(PreProcessor&&)                 = delete; // Move constructor
  PreProcessor& operator=(PreProcessor&&)      = delete; // Move assignment

  std::vector<std::string> process(std::vector<std::string>);

protected:
  PreProcessor();

private:
  std::string::size_type prev_indent;
  int unclosed_indents;
};

#endif // PREPROCESSOR_H
