module Linters
  module Swiftlint
    class Tokenizer
      VIOLATION_REGEX = /\A
        (?<filepath>[^:]+):
        (?<line_number>\d+):
        (?<column_number>\d+):\s
        (?<error_level>\w+):\s
        (?<message>.+)
      \z/x

      def parse(text)
        Linters::Tokenizer.new(text, VIOLATION_REGEX).parse
      end
    end
  end
end
