#ifndef htmlencode_hpp
#define htmlencode_hpp

#include <string>
#include "../lib/utf8.h"

int is_safe_char(UTF32_INT_TYPE c);
bool is_utf8_string(const char *p);
std::string html_encode(const char *p);

#endif
