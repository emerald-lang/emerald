# frozen_string_literal: true

require "colorize"
require "fileutils"
require "logger"
require "tempfile"

module Emerald
  class Generator
    attr_accessor :logger
    def node(name)
      @logger = ::Logger.new(STDOUT)

      write_header_file(name)
      write_source_file(name)
      update_grammar_file(name)
    end

    private

    def write_header_file(name)
      logger.info "[Info] Writing header file src/nodes/#{name}.hpp..."

      File.open("src/nodes/#{name}.hpp", "w") do |file|
        file.write <<~EOF
          #ifndef #{upcase!(name)}_H
          #define #{upcase!(name)}_H

          #include "node.hpp"

          class #{class!(name)} : public Node {

          public:
            #{class!(name)}(NodePtr);

            std::string to_html(Json &context) override;

          private:
            NodePtr something;

          };

          #endif // #{upcase!(name)}_H
        EOF
      end

      logger.info "[Create] Wrote header file src/nodes/#{name}.hpp.".colorize(:green)
    end

    def write_source_file(name)
      logger.info "[Info] Writing source file src/nodes/#{name}.cpp."

      File.open("src/nodes/#{name}.cpp", "w") do |file|
        file.write <<~EOF
          #include "#{name}.hpp"

          #{class!(name)}::#{class!(name)}(NodePtr something) : something(something) {}

          std::string #{class!(name)}::to_html(Json &context) {
            return line->to_html(context);
          }
        EOF
      end

      logger.info "[Create] Wrote source file src/nodes/#{name}.cpp.".colorize(:green)
    end

    def update_grammar_file(name)
      logger.info "[Info] Updating grammar file src/grammar.cpp..."

      file_path    = "src/grammar.cpp"
      grammar_rule = <<-EOF
  emerald_parser["#{name}"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      NodePtr something = sv[0].get<NodePtr>();

      return NodePtr(new #{class!(name)}(something));
    };

      EOF

      modified_contents = File.readlines(file_path).map do |line|
        end_of_parser_rules?(line) ? grammar_rule + line : line
      end
      File.open("src/grammar.cpp", "w") { |file| file.write modified_contents.join }

      logger.info "[Update] Updated grammar file src/grammar.cpp.".colorize(:green)
    end

    def class!(str)
      str.split('_').collect(&:capitalize).join
    end

    def upcase!(str)
      str.gsub('_', '').upcase
    end

    def end_of_parser_rules?(line)
      line.strip == "emerald_parser.enable_packrat_parsing();"
    end
  end
end
