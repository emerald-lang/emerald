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

    REQUIRE(TestHelper::convert(input, { "prefix", "class-prefix" }) == output);
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
      "pre ->",
      "  Hello, world,",
      "  my name is |name|"
    };
    const std::string output = "<pre>Hello, world, my name is Dave</pre>";

    REQUIRE(TestHelper::convert(input, { "name", "Dave" }) == output);
  }

  SECTION("does not template in multiline templateless literals") {
    std::vector<std::string> input = {
      "h1 =>",
      "  Hello, world,",
      "  my name is |name|"
    };
    const std::string output = "<pre>Hello, world, my name is |name|</pre>";

    REQUIRE(TestHelper::convert(input, { "name", "Dave" }) == output);
  }

  SECTION("escaping") {

    SECTION("handles escaped pipes") {
      std::vector<std::string> input = {
        "h1 Hello, \\||name|"
      };
      const char *output = "<h1>Hello, |Andrew</h1>";

      REQUIRE(TestHelper::convert(input, { "name", "Andrew" }) == output);
    }

    SECTION("handles escaped escaped pipes") {
      std::vector<std::string> input = {
        "h1 Hello, \\\\||name|"
      };
      const char *output = "<h1>Hello, \\Dave</h1>";

      REQUIRE(TestHelper::convert(input, { "name", "Dave" }) == output);
    }

    SECTION("handles braces in multiline literals") {
      std::vector<std::string> input = {
        "h1 =>",
        "  hey look a brace",
        "  }"
      };
      const char *output = "<h1>hey look a brace }</h1>";

      REQUIRE(TestHelper::convert(input, {}) == output);
    }

    SECTION("handles braces in inline literals") {
      std::vector<std::string> input = {
        "h1 hey look a brace }"
      };
      const char *output = "<h1>hey look a brace }</h1>";

      REQUIRE(TestHelper::convert(input, {}) == output);
    }

    SECTION("does not template templateless literals") {
      std::vector<std::string> input = {
        "h1 =>",
        "  if (a || b) {",
        "    console.log(\"truthy\\n\");",
        "  }"
      };
      const char *output =
        "<h1>if (a || b) {"
        "  console.log(&quot;truthy\\n&quot;);"
        "}</h1>";

      REQUIRE(TestHelper::convert(input, {}) == TestHelper::whitespace_agnostic(output));
    }

    SECTION("escaping parentheses works") {
      std::vector<std::string> input = {
        "section here's some text \\(and some stuff in brackets\\)"
      };
      const char *output =
        "<section class=\"something\">here\'s some text (and some stuff in brackets)</section>";

      REQUIRE(TestHelper::convert(input, {}) == output);
    }

  } // SECTION("escaping")

} // TEST_CASE("templating", "[grammar]")
