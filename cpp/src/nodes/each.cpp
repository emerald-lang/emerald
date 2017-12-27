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
    return each_in_collection(collection, body, context, false);
  } else if (collection.is_array()) {
    return each_in_collection(collection, body, context, true);
  } else {
    return "";
  }
}

std::string Each::each_in_collection(const Json& collection, NodePtr body, const Json& context, bool key_is_index) const {
  std::vector<std::string> iterations;

  // For each element in the collection
  for (Json::const_iterator it = collection.begin(); it < collection.end(); ++it) {

    // Make a new context with the element's key and value added at the root level
    Json new_context(context);

    // Add value
    new_context[val_name] = it.value();

    // Add key, if specified
    if (!key_name.empty()) {
      if (key_is_index) {
        // Get the iteration of the loop
        new_context[key_name] = it - collection.begin();
      } else {

        // Get the string name of the key
        new_context[key_name] = it.key();
      }
    }
    iterations.push_back(body->to_html(new_context));
  }

  return boost::algorithm::join(iterations, "\n");
}
