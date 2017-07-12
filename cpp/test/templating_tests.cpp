#include "test_helper.hpp"
#include "../src/preprocessor.hpp"

TEST_CASE("templating", "[grammar]") {

  SECTION("works with no templating") {
    std::vector<std::string> input = {
      "h1 Hello, world"
    };
    const char *output = "<h1>Hello, world</h1>";

    REQUIRE(TestHelper::convert(input, {}) == output);
  }

  SECTION("templating works for attributes") {
    std::vector<std::string> input = {
      "section Attributes follow parentheses. ("
        "id     \"header\""
        "class  \"|prefix|-text\""
        "height \"50px\""
        "width  \"200px\""
    };
    const char *output =
      "<section id=\"header\" class=\"class-prefix-text\" height=\"50px\" width=\"200px\">"
      "Attributes follow parentheses.</section>";

    REQUIRE(TestHelper::convert(input, {}) == output);
  }

  SECTION("works with simple templating") {
    std::vector<std::string> input = {
      "h1 Hello, |name|"
    };
    const char *output = "<h1>Hello, Dave</h1>";

    REQUIRE(TestHelper::convert(input, { "name", "Dave" }) == output);
  }

  SECTION("works with nested templating") {
    std::vector<std::string> input = {
      "h1 Hello, |person.name|"
    };
    const char *output = "<h1>Hello, Andrew</h1>";

    REQUIRE(TestHelper::convert(input, { "person", { "name", "Andrew" } }) == output);
  }

  SECTION("works in multiline literals") {
    std::vector<std::string> input = {
      "pre ->"
      "  Hello, world,",
      "  my name is |name|"
    };
    const char *output = "<h1>Hello, Dave</h1>";

    REQUIRE(TestHelper::convert(input, { "name", "Dave" }) == output);
  }

} // TEST_CASE("templating", "[grammar]")
