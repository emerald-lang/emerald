#include <stdlib.h>
#include <string.h>
#include <sstream>
#include <map>
#include "htmlencode.hpp"

std::map<std::string, std::string> entities = {
	{ "Æ", "AElig" },
	{ "Á", "Aacute" },
	{ "Â", "Acirc" },
	{ "À", "Agrave" },
	{ "Α", "Alpha" },
	{ "Å", "Aring" },
	{ "Ã", "Atilde" },
	{ "Ä", "Auml" },
	{ "Β", "Beta" },
	{ "Ç", "Ccedil" },
	{ "Χ", "Chi" },
	{ "‡", "Dagger" },
	{ "Δ", "Delta" },
	{ "Ð", "ETH" },
	{ "É", "Eacute" },
	{ "Ê", "Ecirc" },
	{ "È", "Egrave" },
	{ "Ε", "Epsilon" },
	{ "Η", "Eta" },
	{ "Ë", "Euml" },
	{ "Γ", "Gamma" },
	{ "Í", "Iacute" },
	{ "Î", "Icirc" },
	{ "Ì", "Igrave" },
	{ "Ι", "Iota" },
	{ "Ï", "Iuml" },
	{ "Κ", "Kappa" },
	{ "Λ", "Lambda" },
	{ "Μ", "Mu" },
	{ "Ñ", "Ntilde" },
	{ "Ν", "Nu" },
	{ "Œ", "OElig" },
	{ "Ó", "Oacute" },
	{ "Ô", "Ocirc" },
	{ "Ò", "Ograve" },
	{ "Ω", "Omega" },
	{ "Ο", "Omicron" },
	{ "Ø", "Oslash" },
	{ "Õ", "Otilde" },
	{ "Ö", "Ouml" },
	{ "Φ", "Phi" },
	{ "Π", "Pi" },
	{ "″", "Prime" },
	{ "Ψ", "Psi" },
	{ "Ρ", "Rho" },
	{ "Š", "Scaron" },
	{ "Σ", "Sigma" },
	{ "Þ", "THORN" },
	{ "Τ", "Tau" },
	{ "Θ", "Theta" },
	{ "Ú", "Uacute" },
	{ "Û", "Ucirc" },
	{ "Ù", "Ugrave" },
	{ "Υ", "Upsilon" },
	{ "Ü", "Uuml" },
	{ "Ξ", "Xi" },
	{ "Ý", "Yacute" },
	{ "Ÿ", "Yuml" },
	{ "Ζ", "Zeta" },
	{ "á", "aacute" },
	{ "â", "acirc" },
	{ "´", "acute" },
	{ "æ", "aelig" },
	{ "à", "agrave" },
	{ "ℵ", "alefsym" },
	{ "α", "alpha" },
	{ "&", "amp" },
	{ "∧", "and" },
	{ "∠", "ang" },
	{ "'", "apos" },
	{ "å", "aring" },
	{ "≈", "asymp" },
	{ "ã", "atilde" },
	{ "ä", "auml" },
	{ "„", "bdquo" },
	{ "β", "beta" },
	{ "¦", "brvbar" },
	{ "•", "bull" },
	{ "∩", "cap" },
	{ "ç", "ccedil" },
	{ "¸", "cedil" },
	{ "¢", "cent" },
	{ "χ", "chi" },
	{ "ˆ", "circ" },
	{ "♣", "clubs" },
	{ "≅", "cong" },
	{ "©", "copy" },
	{ "↵", "crarr" },
	{ "∪", "cup" },
	{ "¤", "curren" },
	{ "⇓", "dArr" },
	{ "†", "dagger" },
	{ "↓", "darr" },
	{ "°", "deg" },
	{ "δ", "delta" },
	{ "♦", "diams" },
	{ "÷", "divide" },
	{ "é", "eacute" },
	{ "ê", "ecirc" },
	{ "è", "egrave" },
	{ "∅", "empty" },
	{ "\xE2\x80\x83", "emsp" },
	{ "\xE2\x80\x82", "ensp" },
	{ "ε", "epsilon" },
	{ "≡", "equiv" },
	{ "η", "eta" },
	{ "ð", "eth" },
	{ "ë", "euml" },
	{ "€", "euro" },
	{ "∃", "exist" },
	{ "ƒ", "fnof" },
	{ "∀", "forall" },
	{ "½", "frac12" },
	{ "¼", "frac14" },
	{ "¾", "frac34" },
	{ "⁄", "frasl" },
	{ "γ", "gamma" },
	{ "≥", "ge" },
	{ ">", "gt" },
	{ "⇔", "hArr" },
	{ "↔", "harr" },
	{ "♥", "hearts" },
	{ "…", "hellip" },
	{ "í", "iacute" },
	{ "î", "icirc" },
	{ "¡", "iexcl" },
	{ "ì", "igrave" },
	{ "ℑ", "image" },
	{ "∞", "infin" },
	{ "∫", "int" },
	{ "ι", "iota" },
	{ "¿", "iquest" },
	{ "∈", "isin" },
	{ "ï", "iuml" },
	{ "κ", "kappa" },
	{ "⇐", "lArr" },
	{ "λ", "lambda" },
	{ "〈", "lang" },
	{ "«", "laquo" },
	{ "←", "larr" },
	{ "⌈", "lceil" },
	{ "“", "ldquo" },
	{ "≤", "le" },
	{ "⌊", "lfloor" },
	{ "∗", "lowast" },
	{ "◊", "loz" },
	{ "\xE2\x80\x8E", "lrm" },
	{ "‹", "lsaquo" },
	{ "‘", "lsquo" },
	{ "<", "lt" },
	{ "¯", "macr" },
	{ "—", "mdash" },
	{ "µ", "micro" },
	{ "·", "middot" },
	{ "−", "minus" },
	{ "μ", "mu" },
	{ "∇", "nabla" },
	{ "\xC2\xA0", "nbsp" },
	{ "–", "ndash" },
	{ "≠", "ne" },
	{ "∋", "ni" },
	{ "¬", "not" },
	{ "∉", "notin" },
	{ "⊄", "nsub" },
	{ "ñ", "ntilde" },
	{ "ν", "nu" },
	{ "ó", "oacute" },
	{ "ô", "ocirc" },
	{ "œ", "oelig" },
	{ "ò", "ograve" },
	{ "‾", "oline" },
	{ "ω", "omega" },
	{ "ο", "omicron" },
	{ "⊕", "oplus" },
	{ "∨", "or" },
	{ "ª", "ordf" },
	{ "º", "ordm" },
	{ "ø", "oslash" },
	{ "õ", "otilde" },
	{ "⊗", "otimes" },
	{ "ö", "ouml" },
	{ "¶", "para" },
	{ "∂", "part" },
	{ "‰", "permil" },
	{ "⊥", "perp" },
	{ "φ", "phi" },
	{ "π", "pi" },
	{ "ϖ", "piv" },
	{ "±", "plusmn" },
	{ "£", "pound" },
	{ "′", "prime" },
	{ "∏", "prod" },
	{ "∝", "prop" },
	{ "ψ", "psi" },
	{ "\"", "quot" },
	{ "⇒", "rArr" },
	{ "√", "radic" },
	{ "〉", "rang" },
	{ "»", "raquo" },
	{ "→", "rarr" },
	{ "⌉", "rceil" },
	{ "”", "rdquo" },
	{ "ℜ", "real" },
	{ "®", "reg" },
	{ "⌋", "rfloor" },
	{ "ρ", "rho" },
	{ "\xE2\x80\x8F", "rlm" },
	{ "›", "rsaquo" },
	{ "’", "rsquo" },
	{ "‚", "sbquo" },
	{ "š", "scaron" },
	{ "⋅", "sdot" },
	{ "§", "sect" },
	{ "\xC2\xAD", "shy" },
	{ "σ", "sigma" },
	{ "ς", "sigmaf" },
	{ "∼", "sim" },
	{ "♠", "spades" },
	{ "⊂", "sub" },
	{ "⊆", "sube" },
	{ "∑", "sum" },
	{ "¹", "sup1" },
	{ "²", "sup2" },
	{ "³", "sup3" },
	{ "⊃", "sup" },
	{ "⊇", "supe" },
	{ "ß", "szlig" },
	{ "τ", "tau" },
	{ "∴", "there4" },
	{ "θ", "theta" },
	{ "ϑ", "thetasym" },
	{ "\xE2\x80\x89", "thinsp" },
	{ "þ", "thorn" },
	{ "˜", "tilde" },
	{ "×", "times" },
	{ "™", "trade" },
	{ "⇑", "uArr" },
	{ "ú", "uacute" },
	{ "↑", "uarr" },
	{ "û", "ucirc" },
	{ "ù", "ugrave" },
	{ "¨", "uml" },
	{ "ϒ", "upsih" },
	{ "υ", "upsilon" },
	{ "ü", "uuml" },
	{ "℘", "weierp" },
	{ "ξ", "xi" },
	{ "ý", "yacute" },
	{ "¥", "yen" },
	{ "ÿ", "yuml" },
	{ "ζ", "zeta" },
	{ "\xE2\x80\x8D", "zwj" },
	{ "\xE2\x80\x8C", "zwnj" }
};

int is_safe_char(UTF32_INT_TYPE c) {
  return c <= 127;
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

std::string c_substr(const char *p, size_t len) {
  std::string result;
  for (size_t i = 0; i < len; i++, p++) {
    result += *p;
  }
  return result;
}

std::string html_encode(const char *p) {
  size_t size = strlen(p);
  std::stringstream result;
  while ('\0' != *p) {
    UTF32_INT_TYPE c;
    size_t clen;

    c = utf8_decode(p, size);
    clen = utf8_first_byte_length_hint(*p);

    // See if the unicode character has an entity. It may
    // be multiple bytes long, so we have to copy all the
    // bytes of the character into a string rather than
    // using a single character
    auto entity = entities.find(c_substr(p, clen));

    // Use named entity if it exists
    if (entity != entities.end()) {
      result << "&" << entity->second << ";";

    // If it's not a regular ascii character, use its numeric value
    } else if (!is_safe_char(c)) {
      result << "&#" << (unsigned long) c << ";";

    } else {
      result << (char)c;
    }

    size -= clen;
    p += clen;
  }

  return result.str();
}
