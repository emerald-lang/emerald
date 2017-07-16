/**
 * Emerald, the language agnostic templating engine.
 *
 * Copyright (c) 2016-2017 Andrew McBurney, Dave Pagurek, Yu Chen Hu, Google Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#include <cstring>
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

#include "grammar.hpp"
#include "preprocessor.hpp"

void print_usage() {
  std::cout << "usage: emerald PATH [--ast]" << std::endl;
  exit(0);
}

void exit_and_error() {
  std::cerr << "Error, could not open input file." << std::endl;
  exit(0);
}

/**
 * Try to open file passed in from command line, and parse file input with
 * Emerald grammar
 */
int main(int argc, char** argv) {
  if (argc < 1) print_usage();

  std::string line, parsed;
  std::vector<std::string> lines;

  // Try to open a file from name passed in from command line
  try {
    // Get text input from file
    std::ifstream input_file(argv[1]);

    // Exit if it fails
    if (input_file.fail()) exit_and_error();

    // Get file input line by line
    while (std::getline(input_file, line)) lines.push_back(line);

    // Preprocess the emerald source code
    PreProcessor processor(lines);
    std::string output = processor.get_output();

    // Get parser member from singleton 'Grammar' class
    peg::parser parser = Grammar::get_instance().get_parser();

    // Parse preprocessed string
    parser.parse(output.c_str(), parsed);

    std::cout << parsed << std::endl;
  } catch (const std::ifstream::failure& e) {
    std::cout << "Exception opening/reading file" << std::endl;
  }
}
