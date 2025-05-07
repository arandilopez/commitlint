# frozen_string_literal: true

require_relative "commitlint/version"
require_relative "commitlint/validator"
require_relative "commitlint/linter"
require_relative "commitlint/cli"

module Commitlint
  class Error < StandardError; end

  VALID_TYPES = %w[feat fix docs style refactor perf test chore revert].freeze
  CONVENTIONAL_COMMIT_SCHEMA = /(?x)
    ^(?<type>#{VALID_TYPES.join("|")})  # Type
    (\((?<scope>.*?)\))?                # Optional scope
    !?                                  # Optional exclamation mark
    :                                   # Required colon
    \s                                  # Required space
    (?<subject>.*)                      # Required subject
    (\n\n(?<body>.*))?                  # Optional body
    (\n\n(?<footer>.*))?                # Optional footer
  /
end
