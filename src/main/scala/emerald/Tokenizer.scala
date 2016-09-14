package emerald

import scala.io.Source
import scala.util.control.Breaks._

object Tokenizer {
  def init (path :String) {
    var input :String = Source.fromFile(path).mkString

    // Match and create tokens recursively
    def tokenize  (input :String, tokens :List[String]) :List[String] = {
      if (input.isEmpty) return tokens

      print ("INPUT: " + input)

      input match {
         case s if s.startsWith("html\\b") => tokenize (input.stripPrefix("html"), tokens :+ "html")
         case s if s.startsWith("doc")  => tokenize (input.stripPrefix("doc"),  tokens :+ "doc")
         case s if s.startsWith("head") => tokenize (input.stripPrefix("head"), tokens :+ "head")
         case s if s.startsWith("body") => tokenize (input.stripPrefix("body"), tokens :+ "body")
         case s if s.startsWith("\\B")    => tokenize (input.trim, tokens)
         case _ => tokenize (input.tail, tokens)
      }
    }

    // List of tokens from tokenize method.
    var tok :List[String] = tokenize (input, List())

    tok.foreach {
      println
    }
  }
}
