#include "test_helper.hpp"
#include "../src/preprocessor.hpp"

TEST_CASE("source maps", "[preprocessor]") {
  SECTION("mapping lines from output to input") {
    std::vector<std::string> input = {
      "div",
      "  test"
    };
    PreProcessor p(input);
    REQUIRE(p.get_source_map()[1] == 1);
    REQUIRE(p.get_source_map()[3] == 2);
  }
}

TEST_CASE("multiline literals", "[preprocessor]") {
  SECTION("preprocessing multiline literals") {
    std::vector<std::string> input = {
      "h1 =>",
      "  This is a multiline literal"
    };
    std::vector<std::string> output = {
      "h1 =>",
      "This is a multiline literal",
      "$"
    };
    PreProcessor p(input);
    REQUIRE(p.get_output() == TestHelper::concat(output));
  }

  SECTION("encoding HTML entities") {
    std::vector<std::string> input = {
      "h1 =>",
      "  <div>"
    };
    std::vector<std::string> output = {
      "h1 =>",
      "&lt;div&gt;",
      "$"
    };
    PreProcessor p(input);
    REQUIRE(p.get_output() == TestHelper::concat(output));
  }

  SECTION("encoding utf8 characters without semantic names") {
    std::vector<std::string> input = {
      "h1 =>",
      "  👌"
    };
    std::vector<std::string> output = {
      "h1 =>",
      "&#128076;",
      "$"
    };
    PreProcessor p(input);
    REQUIRE(p.get_output() == TestHelper::concat(output));
  }

  SECTION("skipping HTML entity encoding for ~> literals") {
    std::vector<std::string> input = {
      "h1 ~>",
      "  <div>"
    };
    std::vector<std::string> output = {
      "h1 ~>",
      "<div>",
      "$"
    };
    PreProcessor p(input);
    REQUIRE(p.get_output() == TestHelper::concat(output));
  }

  SECTION("escaping dollar signs") {
    std::vector<std::string> input = {
      "h1 =>",
      "  Thi$ i$ a multiline literal"
    };
    std::vector<std::string> output = {
      "h1 =>",
      "Thi\\$ i\\$ a multiline literal",
      "$"
    };
    PreProcessor p(input);
    REQUIRE(p.get_output() == TestHelper::concat(output));
  }

  SECTION("preserving empty lines") {
    std::vector<std::string> input = {
      "pre =>",
      "  line",
      "",
      "  line"
    };
    std::vector<std::string> output = {
      "pre =>",
      "line",
      "",
      "line",
      "$"
    };
    PreProcessor p(input);
    REQUIRE(p.get_output() == TestHelper::concat(output));
  }
}

TEST_CASE("converting nesting") {
  SECTION("adding braces around nested tags") {
    std::vector<std::string> input = {
      "div",
      "  p test"
    };
    std::vector<std::string> output = {
      "div",
      "{",
      "p test",
      "}"
    };
    PreProcessor p(input);
    REQUIRE(p.get_output() == concat(output));
  }

  SECTION("adding braces around attributes") {
    std::vector<std::string> input = {
      "h1 test (",
      "  class \"title\"",
      ")"
    };
    std::vector<std::string> output = {
      "h1 test (",
      "{",
      "class \"title\"",
      "}",
      ")"
    };
    PreProcessor p(input);
    REQUIRE(p.get_output() == concat(output));
  }
}
