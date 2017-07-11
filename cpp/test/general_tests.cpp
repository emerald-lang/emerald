#include "test_helper.hpp"

TEST_CASE("attributes", "[general]") {

  SECTION("supports nested tags with attributes") {
    std::vector<std::string> input = {
      "section (",
      "  class 'something'",
      ")",
      "  h1 Test"
    };
    const char *output = "<section class='something'><h1>Test</h1></section>";

    REQUIRE(TestHelper::convert(input, {}) == output);
  }

  SECTION("text rule works with attributes") {
    std::vector<std::string> input = {
      "h1 Attributes follow parentheses. (",
      "  id     'header'",
      "  class  'main-text'",
      "  height '50px'",
      "  width  '200px'",
      ")"
    };
    const char *output =
      "<h1 id='header' class='main-text' height='50px' width='200px'>"
      "Attributes follow parentheses.</h1>";

    REQUIRE(TestHelper::convert(input, {}) == output);
  }

  SECTION("tag statement rule works with attributes") {
    std::vector<std::string> input = {
      "section Attributes follow parentheses. (",
      "  id     'header'",
      "  class  'main-text'",
      "  height '50px'",
      "  width  '200px'",
      ")"
    };
    const char *output =
      "<section id='header' class='main-text' height='50px' width='200px'>"
      "Attributes follow parentheses.</section>";

    REQUIRE(TestHelper::convert(input, {}) == output);
  }

  SECTION("supports single line comments") {
    std::vector<std::string> input = {
      "* test",
      "h1 test"
    };
    const char *output = "<!-- test --> <h1>test</h1>";

    REQUIRE(TestHelper::convert(input, {}) == output);
  }

  SECTION("supports multiline comments") {
    std::vector<std::string> input = {
      "* ->",
      "  test",
      "h1 test"
    };
    const char *output = "<!-- test --> <h1>test</h1>";

    REQUIRE(TestHelper::convert(input, {}) == output);
  }

  SECTION("inline identifiers") {

    SECTION("converts classes") {
      std::vector<std::string> input = {
        "h1.something test"
      };
      const char *output = "<h1 class=\"something\">test</h1>";

      REQUIRE(TestHelper::convert(input, {}) == output);
    }

    SECTION("converts multiple classes") {
      std::vector<std::string> input = {
        "h1.a.b test"
      };
      const char *output = "<h1 class=\"a b\">test</h1>";

      REQUIRE(TestHelper::convert(input, {}) == output);
    }

    SECTION("supports ids") {
      std::vector<std::string> input = {
        "h1#some-id_ test"
      };
      const char *output = "<h1 id=\"some-id_\">test</h1>";

      REQUIRE(TestHelper::convert(input, {}) == output);
    }

    SECTION("supports classes and ids") {
      std::vector<std::string> input = {
        "h1#a.b.c test"
      };
      const char *output = "<h1 id=\"a\" class=\"b c\">test</h1>";

      REQUIRE(TestHelper::convert(input, {}) == output);
    }

    SECTION("self-closes void tags") {
      std::vector<std::string> input = {
        "img"
      };
      const char *output = "<img />";

      REQUIRE(TestHelper::convert(input, {}) == output);
    }

  } // SECTION("inline identifiers")

  SECTION("list rules") {

    SECTION("supports \'images\' special rule") {
      std::vector<std::string> input = {
        "images",
        "  'images/nav/home.png'",
        "  'images/nav/about.png'",
        "  'images/nav/blog.png'",
        "  'images/nav/contact.png'"
      };
      const char *output =
        "<img src=\"images/nav/home.png\"/> "
        "<img src=\"images/nav/about.png\"/> "
        "<img src=\"images/nav/blog.png\"/> "
        "<img src=\"images/nav/contact.png\"/>";

      REQUIRE(TestHelper::convert(input, {}) == output);
    }

    SECTION("supports \'images\' base rule") {
      std::vector<std::string> input = {
        "images",
        "  src 'images/nav/home.png'",
        "  src 'images/nav/about.png'",
        "  src 'images/nav/blog.png'",
        "  src 'images/nav/contact.png'"
      };
      const char *output =
        "<img src=\"images/nav/home.png\"/> "
        "<img src=\"images/nav/about.png\"/> "
        "<img src=\"images/nav/blog.png\"/> "
        "<img src=\"images/nav/contact.png\"/>";

      REQUIRE(TestHelper::convert(input, {}) == output);
    }

    SECTION("supports \'scripts\' special rule") {
      std::vector<std::string> input = {
        "scripts",
        "  'vendor/jquery.js'",
        "  'js/main.js'"
      };
      const char *output =
        "<script type=\"text/javascript\" src=\"vendor/jquery.js\"></script> "
        "<script type=\"text/javascript\" src=\"js/main.js\"></script>";

      REQUIRE(TestHelper::convert(input, {}) == output);
    }

    SECTION("supports \'scripts\' base rule") {
      std::vector<std::string> input = {
        "scripts",
        "  type 'text/javascript' src 'vendor/jquery.js'",
        "  type 'text/javascript' src 'js/main.js'"
      };
      const char *output =
        "<script type=\"text/javascript\" src=\"vendor/jquery.js\"></script> "
        "<script type=\"text/javascript\" src=\"js/main.js\"></script>";

      REQUIRE(TestHelper::convert(input, {}) == output);
    }

    SECTION("supports \'styles\' special rule") {
      std::vector<std::string> input = {
        "styles",
        "  'css/main.css'",
        "  'css/footer.css'"
      };
      const char *output =
        "<link rel=\"stylesheet\" href=\"css/main.css\"/> "
        "<link rel=\"stylesheet\" href=\"css/footer.css\"/>";

      REQUIRE(TestHelper::convert(input, {}) == output);
    }

    SECTION("supports \'styles\' base rule") {
      std::vector<std::string> input = {
        "styles",
        "  href 'css/main.css' type 'text/css'",
        "  href 'css/footer.css' type 'text/css'"
      };
      const char *output =
        "<link rel=\"stylesheet\" href=\"css/main.css\"/> "
        "<link rel=\"stylesheet\" href=\"css/footer.css\"/>";

      REQUIRE(TestHelper::convert(input, {}) == output);
    }

    SECTION("supports \'metas\' base rule") {
      std::vector<std::string> input = {
        "metas",
        "  name 'test-name' content 'test-content'",
        "  name 'test-name-2' content 'test-content-2'"
      };
      const char *output =
        "<meta name=\"test-name\" content=\"test-content\"> "
        "<meta name=\"test-name-2\" content=\"test-content-2\">";

      REQUIRE(TestHelper::convert(input, {}) == output);
    }

  } // SECTION("list rules")

} // TEST_CASE("attributes", "[general]")
