package emerald

import scala.io.Source

object Tokenizer {
  def init (path :String) {
    var input :String = Source.fromFile(path).mkString

    // Match and create tokens recursively
    def tokenize  (input :String, tokens :List[String]) :List[String] = {
      input match {
         case s if s.startsWith("html") => println("match")
         case s if s.startsWith("doc")  => println("match 2")
         case _ => None
      }
      tokens
    }
    tokenize (input, List())
  }
}
