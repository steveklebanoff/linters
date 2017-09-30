require "linters/base/options"
require "linters/swiftlint/tokenizer"

module Linters
  module Swiftlint
    class Options
      def command(_filename)
        if `uname`.strip == "Darwin"
          "swiftlint"
        else
          File.join(current_path, "bin", "swiftlint_linux")
        end
      end

      def config_filename
        ".swiftlint.yml"
      end

      def tokenizer
        Tokenizer.new
      end

      def config_content(content)
        content
      end

      private

      def current_path
        File.expand_path("../../..", __dir__)
      end
    end
  end
end
