# frozen_string_literal: true

require 'spec_helper'

# Recursively walk directory and get all test case files for the test suite.
# Performs preprocessing operation on each file and stores the results in a
# hash dictionary, with file name as key.
def walk(path, process, hash = {})
  Dir.foreach(path) do |file|
    new_path = File.join(path, file)

    next if file == '..' || file == '.'
    hash = if process
             get_new_hash(hash, file, new_path)
           else
             get_expected(hash, file, new_path)
           end
  end

  hash
end

# Preprocesses emerald and returns it in the new hash. Walks the new path if
# new path is a directory
def get_new_hash(hash, file, new_path)
  if File.directory?(new_path)
    walk(new_path, true, hash)
  else
    hash[file[/[^\.]+/]] = Emerald::PreProcessor.new.process_emerald(IO.read(new_path))
  end

  hash
end

def get_expected(hash, file, new_path)
  if File.directory?(new_path)
    walk(new_path, false, hash)
  else
    hash[file[/[^\.]+/]] = File.open(new_path, 'r').read
  end

  hash
end

describe Emerald::PreProcessor do
  # We only test the valid samlpes, because the invalid emerald samples will
  # also be preprocessed regardless of their semantics. Error checking happens
  # in the parsing and code generation phase.
  output = walk(__dir__ + '/emerald/', true)
  expected = walk(__dir__ + '/intermediate/', false)

  output.each do |key, value|
    it "works for #{key}" do
      expect(value).to eq(expected[key])
    end
  end

  context 'multiline literals' do
    it 'preprocesses multiline literals' do
      input = <<~EMR
        h1 =>
          This is a multiline literal
      EMR
      output = whitespace_agnostic <<~PREPROCESSED
        h1 =>
        This is a multiline literal
        $
      PREPROCESSED
      expect(preprocess(input)).to eq(output)
    end

    it 'escapes dollar signs' do
      input = <<~EMR
        h1 =>
          Thi$ i$ a multiline literal
      EMR
      output = whitespace_agnostic <<~PREPROCESSED
        h1 =>
        Thi\\$ i\\$ a multiline literal
        $
      PREPROCESSED
      expect(preprocess(input)).to eq(output)
    end
  end
end
