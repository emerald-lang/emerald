# frozen_string_literal: true

require_relative "file_helper.rb"

module Emerald
  class Generator
    include FileHelper

    def node(name)
      write_header_file(name)
      write_source_file(name)
      update_grammar_source_file(name)
    end

    protected

    def write_header_file(name)
      file_contents = <<~EOF
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

      create_file("src/nodes/#{name}.hpp", file_contents)
    end

    def write_source_file(name)
      file_contents = <<~EOF
        #include "#{name}.hpp"

        #{class!(name)}::#{class!(name)}(NodePtr something) : something(something) {}

        std::string #{class!(name)}::to_html(Json &context) {
          return line->to_html(context);
        }
      EOF

      create_file("src/nodes/#{name}.cpp", file_contents)
    end

    def update_grammar_source_file(name)
      grammar_rule = <<-EOF
  emerald_parser["#{name}"] =
    [](const peg::SemanticValues& sv) -> NodePtr {
      NodePtr something = sv[0].get<NodePtr>();

      return NodePtr(new #{class!(name)}(something));
    };

      EOF

      update_file("src/grammar.cpp", "#include \"nodes/#{name}.hpp\"\n", "// [END] Include nodes")
      update_file("src/grammar.cpp", grammar_rule, "// Terminals")
    end

    private

    def class!(str)
      str.split("_").collect(&:capitalize).join
    end

    def upcase!(str)
      str.delete("_").upcase
    end
  end
end
