#ifndef TEXTLITERALCONTENT_H
#define TEXTLITERALCONTENT_H

#include "node.hpp"

class TextLiteralContent : public Node {

public:
  TextLiteralContent(std::string content);

  std::string to_html(Json &context) override;

private:
  std::string content;

};

#endif // TEXTLITERALCONTENT_H
