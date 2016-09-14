package emerald

object Emerald {
  def main (args :Array[String]) {
    if (args.length == 1) {
      Tokenizer.init("src/samples/emerald/" + args(0) + ".emr")
    } else {
      println ("Missing file name or too many arguments.")
    }
  }
}
