require "linters/base/options"
require "linters/credo/tokenizer"

module Linters
  module Credo
    class Options < Linters::Base::Options
      def command(filename)
        "#{strip_import_config(filename)} && " \
          "#{mix("credo #{filename} --strict --all --format=flycheck")}"
      end

      def config_filename
        ".credo.exs"
      end

      def tokenizer
        Tokenizer.new
      end

      def config_content(content)
        content
      end

      private

      def strip_import_config(filename)
        "sed -i.bak '/import_config/d' #{filename}"
      end

      def mix(command)
        "MIX_EXS=#{mix_exs_path} mix #{command}"
      end

      def mix_exs_path
        File.expand_path("mix.exs", project_root)
      end

      def project_root
        File.expand_path("../../../", __dir__)
      end
    end
  end
end
