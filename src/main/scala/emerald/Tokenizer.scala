package emerald

import scala.io.Source
import scala.util.matching.Regex

object Tokenizer {
  def init (path :String) {
    var input :String = Source.fromFile(path).mkString.trim

    // Match and create tokens recursively
    def tokenize  (input :String, tokens :List[String]) :List[String] = {
      if (input.isEmpty) return tokens

      print ("INPUT: " + input)

      input match {
        case s if s.startsWith("html")        => tokenize (input.stripPrefix("html"), tokens :+ "html")
        case s if s.startsWith("doc")         => tokenize (input.stripPrefix("doc"),  tokens :+ "doc")
        case s if s.startsWith("head")        => tokenize (input.stripPrefix("head"), tokens :+ "head")
        case s if s.startsWith("body")        => tokenize (input.stripPrefix("body"), tokens :+ "body")
        case s if s.startsWith("section")     => tokenize (input.stripPrefix("section"), tokens :+ "body")
        case s if s.startsWith("figure")      => tokenize (input.stripPrefix("figure"), tokens :+ "body")
        case s if s.startsWith("figcaption")  => tokenize (input.stripPrefix("figcaption"), tokens :+ "body")
        case s if s.startsWith("img")         => tokenize (input.stripPrefix("body"), tokens :+ "body")
        case s if s.startsWith("acticle")     => tokenize (input.stripPrefix("body"), tokens :+ "body")
        case s if s.startsWith("h1")          => tokenize (input.stripPrefix("body"), tokens :+ "body")
        case s if s.startsWith("h2")          => tokenize (input.stripPrefix("body"), tokens :+ "body")
        case s if s.startsWith("\\B")         => tokenize (input.trim, tokens)
        case _                                => tokenize (input.tail, tokens) // should be an error case
      }
    }

    // List of tokens from tokenize method.
    var tok :List[String] = tokenize (input, List())

    // Print tokens that were matched
    println("\nVALID TOKENS:")
    tok.foreach {println}
  }
}
