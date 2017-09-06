# froze_string_literal: true
require "jobs/linters_job"

RSpec.describe LintersJob, "for sass_lint" do
  include LintersHelper

  context "when file contains violations" do
    it "reports violations" do
      content = <<~SCSS
        .foo {content: 'bar'};
        bar {
          color: '#AAAAAAA'
        }
      SCSS

      expect_violations_in_file(
        content: content,
        filename: "foo/test.scss",
        linter_name: "sass_lint",
        violations: [
          {
            line: 1,
            message: "Space expected between blocks  empty-line-between-blocks",
          },
          {
            line: 3,
            message: "Trailing semicolons required   trailing-semicolon",
          },
        ],
      )
    end
  end

  context "when directory is excluded" do
    it "reports no violations" do
      content = <<~SCSS
        .foo {content: 'bar'};
        bar {
          color: '#AAAAAAA'
        }
      SCSS

      config = <<~CONFIG
        files:
          ignore: "foo/test.scss"
      CONFIG

      expect_violations_in_file(
        config: config,
        content: content,
        filename: "foo/test.scss",
        linter_name: "sass_lint",
        violations: [],
      )
    end
  end

  context "when syntax is invalid" do
    it "reports block is invalid at from a particular line" do
      invalid_content = <<~SCSS
        .foo { content: 'bar'
        {
      SCSS
      message = <<~STR
        Please check validity of the block starting from line #1  Fatal
      STR

      expect_violations_in_file(
        content: invalid_content,
        linter_name: "sass_lint",
        filename: "foo/test.scss",
        violations: [
          line: 1,
          message: message.strip,
        ],
      )
    end
  end
end
