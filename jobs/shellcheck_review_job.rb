require "resque"
require "linters/runner"
require "linters/shellcheck/options"

class ShellcheckReviewJob
  @queue = :shellcheck_review

  def self.perform(attributes)
    Linters::Runner.call(
      linter_options: Linters::Shellcheck::Options.new(
        filepath: attributes.fetch("filename"),
        config_content: attributes.fetch("config"),
      ),
      attributes: attributes,
    )
  end
end
