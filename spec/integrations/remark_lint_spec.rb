require "jobs/linters_job"

RSpec.describe LintersJob, "for remark-lint" do
  include LintersHelper

  context "when file with .md extention contains violations" do
    it "reports violations" do
      expect_violations_in_file(
        content: content,
        filename: "foo/test.md",
        linter_name: "remark",
        violations: [
          {
            line: 1,
            message: "Incorrect list-item indent: add 2 spaces",
          },
          {
            line: 3,
            message: "Found reference to undefined definition",
          },
        ],
      )
    end
  end

  context "when custom configuraton is provided" do
    context "and plugins are an object" do
      it "respects the custom configuration" do
        config = <<~JSON
          {
            "plugins": {
              "remark-preset-lint-recommended": true,
              "lint-list-item-indent": false
            }
          }
        JSON

        expect_violations_in_file(
          config: config,
          content: content,
          filename: "foo/test.md",
          linter_name: "remark",
          violations: [
            {
              line: 3,
              message: "Found reference to undefined definition",
            },
          ],
        )
      end
    end

    context "and plugins are an array" do
      it "respects the custom configuration" do
        config = <<~JSON
          {
            "plugins": [
              "remark-preset-lint-recommended",
              ["lint-list-item-indent", false]
            ]
          }
        JSON

        expect_violations_in_file(
          config: config,
          content: content,
          filename: "foo/test.md",
          linter_name: "remark",
          violations: [
            {
              line: 3,
              message: "Found reference to undefined definition",
            },
          ],
        )
      end
    end
  end

  def content
    <<~MD
      * Hello

      [World][]
    MD
  end
end
