#include "test_helper.hpp"

TEST_CASE("scope", "[grammar]") {

  SECTION("can determine truthiness") {
    std::vector<std::string> input = {
      "given test",
      "  h1 True",
      "unless test",
      "  h1 False"
    };
    const char *output = "<h1>True</h1>";

    REQUIRE(TestHelper::convert(input, { "test", true }) == output);
  }

  SECTION("can determine falsiness") {
    std::vector<std::string> input = {
      "given test",
      "  h1 True",
      "unless test",
      "  h1 False"
    };
    const char *output = "<h1>False</h1>";

    REQUIRE(TestHelper::convert(input, { "test", false }) == output);
  }

  SECTION("can check if a variable is present") {
    std::vector<std::string> input = {
      "given test",
      "  h1 True",
      "unless test",
      "  h1 False"
    };
    const char *output = "<h1>False</h1>";

    REQUIRE(TestHelper::convert(input, {}) == output);
  }

  SECTION("boolean expressions") {

    SECTION("can do OR checks - true branch") {
      std::vector<std::string> input = {
        "given a or b",
        "  h1 True"
      };
      const char *output = "<h1>True</h1>";

      REQUIRE(TestHelper::convert(input, { "a", true, "b", false }) == output);
    }

    SECTION("can do OR checks - false branch") {
      std::vector<std::string> input = {
        "given a or b",
        "  h1 True"
      };
      const char *output = "";

      REQUIRE(TestHelper::convert(input, { "a", false, "b", false }) == output);
    }

    SECTION("can do AND checks - true branch") {
      std::vector<std::string> input = {
        "given a and b",
        "  h1 True"
      };
      const char *output = "<h1>True</h1>";

      REQUIRE(TestHelper::convert(input, { "a", true, "b", true }) == output);
    }

    SECTION("can do AND checks - false branch") {
      std::vector<std::string> input = {
        "given a and b",
        "  h1 True"
      };
      const char *output = "";

      REQUIRE(TestHelper::convert(input, { "a", true, "b", false }) == output);
    }

    SECTION("can do negation - true branch") {
      std::vector<std::string> input = {
        "given not a",
        "  h1 True"
      };
      const char *output = "<h1>True</h1>";

      REQUIRE(TestHelper::convert(input, { "a", false }) == output);
    }

    SECTION("can do negation - false branch") {
      std::vector<std::string> input = {
        "given not a",
        "  h1 True"
      };
      const char *output = "";

      REQUIRE(TestHelper::convert(input, { "a", true }) == output);
    }

    SECTION("can combine expressions - example one") {
      std::vector<std::string> input = {
        "given a and b and c",
        "  h1 True"
      };
      const char *output = "<h1>True</h1>";

      REQUIRE(TestHelper::convert(input, { "a", true, "b", true, "c", true }) == output);
    }

    SECTION("can combine expressions - example two") {
      std::vector<std::string> input = {
        "given a or (b and c)",
        "  h1 True"
      };
      const char *output = "<h1>True</h1>";

      REQUIRE(TestHelper::convert(input, { "a", false, "b", true, "c", true }) == output);
    }

  } // SECTION("boolean expressions")


  SECTION("loops") {

    SECTION("can loop over arrays") {
      std::vector<std::string> input = {
        "each a as element",
        "  h1 |element|"
      };
      const char *output = "<h1>1</h1> <h1>2</h1> <h1>3</h1>";

      REQUIRE(TestHelper::convert(input, { "a", {1, 2, 3} }) == output);
    }

    SECTION("can loop over arrays with indices") {
      std::vector<std::string> input = {
        "each a as element, i",
        "  h1 |i|"
      };
      const char *output = "<h1>0</h1> <h1>1</h1> <h1>2</h1>";

      REQUIRE(TestHelper::convert(input, { "a", {'a', 'b', 'c'} }) == output);
    }

    SECTION("can loop over hashes") {
      std::vector<std::string> input = {
        "each a as v, k"
        "  h1 |v| |k|"
      };
      const char *output = "<h1>b c</h1>";

      REQUIRE(TestHelper::convert(input, { "a", { "b", "c" } }) == output);
    }

  } // SECTION("loops")

  SECTION("with") {

    SECTION("can push scope") {
      std::vector<std::string> input = {
        "with a"
        "  h1 |b|"
      };
      const char *output = "<h1>c</h1>";

      REQUIRE(TestHelper::convert(input, { "a", { "b", "c" } }) == output);
    }

  } // SECTION("with")

} // TEST_CASE("scope", "[grammar]")
