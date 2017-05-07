/* THIS FILE IS PUBLIC DOMAIN. NO WARRANTY OF ANY KIND. NO RIGHTS RESERVED. */
#ifndef UTF8_H_HEADERFILE
#define UTF8_H_HEADERFILE

#ifndef UTF32_INT_TYPE
#define UTF32_INT_TYPE unsigned long
#endif

#ifndef true
#define true 1
#endif
#ifndef false
#define false 0
#endif
#ifndef bool
#define bool int
#endif

static inline bool
utf32_is_surrogate(UTF32_INT_TYPE cp)
{
  return cp > 0xd7ff && cp < 0xe000;
}

static inline bool
utf32_is_non_character(UTF32_INT_TYPE cp)
{
  return ((0xfffeU == (0xffeffffeU & cp) || (cp >= 0xfdd0U && cp <= 0xfdefU)));
}

static inline bool
utf32_is_valid(UTF32_INT_TYPE cp)
{
  return cp < 0x10ffffU && !utf32_is_non_character(cp);
}

static inline unsigned
utf8_encoded_len(UTF32_INT_TYPE cp)
{
  if (cp < 0x80U) {
    return 1;
  } else if (cp < 0x800U) {
    return 2;
  } else if (!utf32_is_valid(cp) || utf32_is_surrogate(cp)) {
    return 0;
  } else if (cp < 0x10000U) {
    return 3;
  } else {
    return 4;
  }
}

static inline unsigned
utf8_first_byte_length_hint(unsigned char ch)
{
  switch (ch & ~0x0fU) {
  case 0x00:
  case 0x10:
  case 0x20:
  case 0x30:
  case 0x40:
  case 0x50:
  case 0x60:
  case 0x70: return 1;
  case 0xc0: return ch >= 0xc2 ? 2 : 0;
  case 0xd0: return 2;
  case 0xe0: return 3;
  case 0xf0: return ch <= 0xf4 ? 4 : 0;
  default:   return 0;
  }
}

static inline bool
utf8_first_byte_valid(unsigned char ch)
{
  return 0 != utf8_first_byte_length_hint(ch);
}

static inline bool
utf8_first_bytes_valid(unsigned char ch1, unsigned char ch2)
{
  if (ch1 < 0x80) {
    return true;
  } else if (0x80 == (ch2 & 0xc0)) {
    /* 0x80..0xbf */
    switch (ch1) {
    case 0xe0: return ch2 >= 0xa0;
    case 0xed: return ch2 <= 0x9f;
    case 0xf0: return ch2 >= 0x90;
    case 0xf4: return ch2 <= 0x8f;
    }
    return true;
  }
  return false;
}

/**
 * @return (UTF32_INT_TYPE-1 on failure. On success the decoded
 *         Unicode codepoint is returned.
 */
static inline UTF32_INT_TYPE
utf8_decode(const char *src, size_t size)
{
  UTF32_INT_TYPE cp;
  unsigned n;

  if (0 == size)
    goto failure;

  cp = (unsigned char) *src;
  n = utf8_first_byte_length_hint(cp);
  if (1 != n) {
    unsigned char x;

    if (0 == n || n > size)
      goto failure;
    
    x = *++src;
    if (!utf8_first_bytes_valid(cp, x))
      goto failure;

    n--;
    cp &= 0x3f >> n;

    for (;;) {
      cp = (cp << 6) | (x & 0x3f);
      if (--n == 0)
        break;
      x = *++src;
      if (0x80 != (x & 0xc0))
        goto failure;
    }
    if (utf32_is_non_character(cp))
      goto failure;
  }
  return cp;

failure:
  return (UTF32_INT_TYPE) -1;
}

static inline unsigned
utf8_encode(UTF32_INT_TYPE cp, char *buf)
{
  unsigned n = utf8_encoded_len(cp);

  if (n > 0) {
    static const unsigned char first_byte[] = {
      0xff, 0x00, 0xc0, 0xe0, 0xf0
    };
    unsigned i = n;

    while (--i > 0) {
      buf[i] = (cp & 0x3f) | 0x80;
      cp >>= 6;
    }
    buf[0] = cp | first_byte[n];
  }
  return n;
}

#endif /* UTF8_H_HEADERFILE */
/* vi: set ai et ts=2 sts=2 sw=2 cindent: */
