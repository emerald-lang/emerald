#include "each.hpp"
#include <vector>

Each::Each(std::string collection_name, std::string val_name, std::string key_name):
  collection_name(collection_name),
  val_name(val_name),
  key_name(key_name)
{}

std::string Each::to_html(NodePtr body, Json &context) const {
  Json collection = context[collection_name];
  if (collection.is_object()) {
    std::vector<std::string> iterations;
    for (Json::const_iterator it = collection.begin(); it < collection.end(); ++it) {
      Json new_context(context);
      new_context[val_name] = it.value();
      if (!key_name.empty()) {
        new_context[key_name] = it.key();
      }
      iterations.push_back(body->to_html(new_context));
    }
    return boost::algorithm::join(iterations, "\n");
  } else if (collection.is_array()) {
    std::vector<std::string> iterations;
    for (Json::const_iterator it = collection.begin(); it < collection.end(); ++it) {
      Json new_context(context);
      new_context[val_name] = *it;
      if (!key_name.empty()) {
        new_context[key_name] = it - collection.begin();
      }
      iterations.push_back(body->to_html(new_context));
    };
    return boost::algorithm::join(iterations, "\n");
  } else {
    return "";
  }
}
