require "test/unit"

class TreetopSuite < Test::Unit::TestCase
  # assert not nil
  def test_directory_output(path)
    Dir.foreach("../samples/emerald/valid") do |file|
      next if file == ".." or file == "." # skips these files
      test_file_output(file)
    end
  end
end
