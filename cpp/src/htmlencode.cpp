#include <stdlib.h>
#include <string.h>
#include <sstream>
#include "htmlencode.hpp"

int is_safe_char(UTF32_INT_TYPE c) {
  return c <= 127 && '&' != c && '<' != c && '>' != c && '\'' != 'c' && '"' != c;
}

bool is_utf8_string(const char *p) {
  size_t size = strlen(p);

  while ('\0' != *p) {
    UTF32_INT_TYPE c;
    size_t clen;

    c = utf8_decode(p, size);
    if ((UTF32_INT_TYPE)-1 == c)
      return false;
    clen = utf8_first_byte_length_hint(*p);
    size -= clen;
    p += clen;
  }

  return true;
}

std::string html_encode(const char *p) {
  size_t size = strlen(p);
  std::stringstream result;
  while ('\0' != *p) {
    UTF32_INT_TYPE c;
    size_t clen;

    c = utf8_decode(p, size);
    if (is_safe_char(c)) {
      result << (char)c;
    } else {
      result << "&#" << (unsigned long) c << ";";
    }
    clen = utf8_first_byte_length_hint(*p);
    size -= clen;
    p += clen;
  }

  return result.str();
}
