#include "catch.hpp"
#include "../src/preprocessor.hpp"
#include <string>
#include <vector>
#include <boost/algorithm/string/join.hpp>

std::string concat(const std::vector<std::string> &v) {
  return boost::algorithm::join(v, "\n") + "\n";
}

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
    REQUIRE(p.get_output() == concat(output));
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
    REQUIRE(p.get_output() == concat(output));
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
    REQUIRE(p.get_output() == concat(output));
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
    REQUIRE(p.get_output() == concat(output));
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
    REQUIRE(p.get_output() == concat(output));
  }
}
