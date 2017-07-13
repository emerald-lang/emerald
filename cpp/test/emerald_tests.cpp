#define CATCH_CONFIG_MAIN

#include "test_helper.hpp"
#include "../src/preprocessor.hpp"
#include "../src/grammar.hpp"

TEST_CASE("accepting valid Emerald", "[grammar]") {
  std::vector<std::string> input = {
    "html",
    "  body",
    "    h1 Hello, world (",
    "      class \"something\"",
    "    )",
    "    p Test"
  };

  PreProcessor p(input);
  REQUIRE(Grammar::get_instance().valid(p.get_output()));
}

TEST_CASE("failing invalid Emerald", "[grammar]") {
  std::vector<std::string> input = {
    "html",
    "  body",
    "    h1 Hello, world (",
    "      class something",
    "    )",
    "    p Test"
  };

  PreProcessor p(input);
  REQUIRE(!Grammar::get_instance().valid(p.get_output()));
}
