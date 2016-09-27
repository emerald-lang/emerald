require_relative '../../ruby/compiler/Analyzer'
require_relative 'Shared'
require "test/unit"

class AnalyzerSuite < Test::Unit::TestCase
  def test_tree(file)
    tokens = Shared.instance.get_tokens(file)
  end
end
