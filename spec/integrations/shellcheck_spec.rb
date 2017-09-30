require "jobs/shellcheck_review_job"

RSpec.describe ShellcheckReviewJob do
  include LintersHelper

  context "when file contains violations" do
    it "reports violations" do
      expect_violations_in_file(
        config: "",
        content: content,
        filename: "foo/bar.sh",
        linter_name: "shellcheck",
        violations: [
          {
            line: 3,
            message: "Double quote to prevent globbing and word splitting.",
          },
          {
            line: 4,
            message: "foo appears unused. Verify it or export it.",
          },
        ],
      )
    end
  end

  context "when custom configuraton is provided" do
    it "respects the custom configuration" do
      config = <<~EOS
        exclude:
          - SC2086
      EOS

      expect_violations_in_file(
        config: config,
        content: content,
        filename: "foo/bar.sh",
        linter_name: "shellcheck",
        violations: [
          {
            line: 4,
            message: "foo appears unused. Verify it or export it.",
          },
        ],
      )
    end
  end

  def content
    <<~EOS
      #!/bin/sh
      hello_world () {
        echo $1
        foo=42
      }
    EOS
  end
end
