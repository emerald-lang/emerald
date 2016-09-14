package emerald

import scala.io.Source

object Tokenizer {
  def init (path :String) {
    var input :String = Source.fromFile(path).mkString
    println (input)
  }
}
