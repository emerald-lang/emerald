/**
 * Emerald, the language agnostic templating engine.
 * Copyright 2016, Emerald Language (MIT)
 */

#include <cstring>
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

#include "grammar.hpp"
#include "preprocessor.hpp"

/**
 * Try to open file passed in from command line, and parse file input with
 * Emerald grammar
 */
int main(int argc, char** argv) {
  std::string line;
  std::string parsed;
  std::vector<std::string> lines;

  // Try to open a file from name passed in from command line
  try {
    // Get text input from file
    std::ifstream input_file(argv[1]);

    // Get file input line by line
    while (std::getline(input_file, line))
      lines.push_back(line);

    // Preprocess the emerald source code
    PreProcessor processor(lines);
    std::string output = processor.get_output();

    // Get parser member from singleton 'Grammar' class
    peg::parser parser = Grammar::get_instance().get_parser();

    // Parse the file input
    for (auto &line : lines) {
      parsed= "";
      parser.parse(line.c_str(), parsed);

      // Only update the line if there's a rule for it
      if (parsed != "")
        line = parsed;
    }

    std::ofstream fout("temp.html");

    // Write out the final lines
    for (auto const &line : lines)
      fout << line << std::endl;

  } catch (const std::ifstream::failure& e) {
    std::cout << "Exception opening/reading file" << std::endl;
  }
}
