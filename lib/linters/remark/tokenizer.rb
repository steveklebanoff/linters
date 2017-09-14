module Linters
  module Remark
    class Tokenizer
      VIOLATION_REGEX = /\A
        \s+
        (?<line_number>\d+):(?<start_column>\d+)
        (-(?<end_line_number>\d+):(?<end_column>\d+))?
        \s{2,}
        (?:\e\[\d+m)?
        (?<violation_level>\w+)?
        (?:\e\[\d+m)?
        \s{2,}
        (?<message>.+?)
        \s{2,}
        (?<rule-name>.+?)
        \s{2,}
        (?<source>.+?)
      \z/x

      def parse(text)
        Linters::Tokenizer.new(text, VIOLATION_REGEX).parse
      end
    end
  end
end
