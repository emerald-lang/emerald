#define CATCH_CONFIG_MAIN

#include "test_helper.hpp"
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

  PreProcessor p;
  REQUIRE(Grammar::get_instance().valid(p.process(input)));
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

  PreProcessor p;
  REQUIRE(!Grammar::get_instance().valid(p.process(input)));
}
