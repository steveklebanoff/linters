require "linters/base/options"
require "linters/remark/tokenizer"

module Linters
  module Remark
    class Options
      def command(filename)
        cmd = "remark-cli/cli.js #{filename}"
        "NODE_PATH=#{node_modules_path} #{File.join(node_modules_path, cmd)}"
      end

      def config_filename
        ".remarkrc"
      end

      def tokenizer
        Tokenizer.new
      end

      def config_content(content)
        if JSON.parse(content).any?
          content
        else
          config(content).to_json
        end
      end

      private

      def node_modules_path
        File.join(current_path, "node_modules")
      end

      def current_path
        File.expand_path("../../..", __dir__)
      end

      def config(content)
        Config.new(content: content, default_config_path: "config/remarkrc")
      end
    end
  end
end
