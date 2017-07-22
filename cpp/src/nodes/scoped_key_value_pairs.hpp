#ifndef SCOPEDKEYVALUEPAIRS_H
#define SCOPEDKEYVALUEPAIRS_H

#include "node.hpp"

/**
 * Scoped key value pairs, scoped to a particular base_keyword in 'pair_list' rule
 *
 * Scoped to pair_list (has knowledge of base_keyword, NOTE: not a parser rule in emerald_parser)
 */
class ScopedKeyValuePairs : public Node {

public:
  ScopedKeyValuePairs(std::string, NodePtrs);

  std::string to_html(Json &context) override;

private:
  std::string keyword;
  NodePtrs pairs;

};

#endif // SCOPEDKEYVALUEPAIRS_H
