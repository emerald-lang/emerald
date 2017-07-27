#include "pair_list.hpp"

PairList::PairList(NodePtrs scoped_key_value_pairs) : scoped_key_value_pairs(scoped_key_value_pairs) {}

std::string PairList::to_html(Json &context) {
  std::vector<std::string> html_vector;
  std::transform(key_value_pairs.begin(), key_value_pairs.end(), html_vector.begin(),
                 [&](NodePtr p) { return p->to_html(context); });

  return boost::algorithm::join(html_vector, "\n");
}
