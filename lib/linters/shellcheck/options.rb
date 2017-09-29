require "linters/base/options"
require "linters/shellcheck/tokenizer"

module Linters
  module Shellcheck
    class Options < Linters::Base::Options
      def command(filename)
        "shellcheck #{filename}"
      end

      def tokenizer
        Tokenizer.new
      end

      def config_content(_content)
      end
    end
  end
end
