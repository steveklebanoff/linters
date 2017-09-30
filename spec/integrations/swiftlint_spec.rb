require "jobs/linters_job"

RSpec.describe LintersJob, "for swiftlint" do
  include LintersHelper

  context "when file with .swift extention contains violations" do
    it "reports violations" do
      expect_violations_in_file(
        content: content,
        filename: "foo/test.swift",
        linter_name: "swiftlint",
        violations: [
          {
            line: 2,
            message: "Trailing Semicolon Violation: Lines should not have" \
              " trailing semicolons. (trailing_semicolon)",
          },
          {
            line: 1,
            message: "Force Cast Violation: Force casts should be avoided." \
              " (force_cast)",
          },
        ],
      )
    end
  end

  context "when custom configuraton is provided" do
    context "and plugins are an object" do
      it "respects the custom configuration" do
        config = <<~YAML
          disabled_rules:
            - force_cast
        YAML

        expect_violations_in_file(
          config: config,
          content: content,
          filename: "foo/test.swift",
          linter_name: "swiftlint",
          violations: [
            {
              line: 2,
              message: "Trailing Semicolon Violation: Lines should not have" \
                " trailing semicolons. (trailing_semicolon)",
            },
          ],
        )
      end
    end
  end

  def content
    <<~TEXT
      let colonOnWrongSide: Int = 0 as! Int
      print("test");
    TEXT
  end
end
