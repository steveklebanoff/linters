require "linters/base/options"
require "linters/shellcheck/tokenizer"

module Linters
  module Shellcheck
    class Options < Linters::Base::Options
      def initialize(filepath:, config_content:)
        @filepath = filepath
        @raw_config_content = config_content
      end

      def command(_filename)
        "shellcheck #{command_options} #{filepath}"
      end

      def tokenizer
        Tokenizer.new
      end

      def config_content(_content)
      end

      private

      attr_reader :filepath, :raw_config_content

      def command_options
        excluded_rules = config["exclude"]
        if excluded_rules
          "-e #{excluded_rules.join(',')}"
        end
      end

      def config
        YAML.safe_load(raw_config_content).to_h
      end
    end
  end
end
