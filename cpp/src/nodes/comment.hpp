#ifndef COMMENT_H
#define COMMENT_H

#include "node.hpp"

class Comment : public Node {

public:
  Comment(NodePtr);

  std::string to_html(Json &context) override;

private:
  NodePtr text_content;

};

#endif // COMMENT_H
