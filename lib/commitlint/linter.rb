# frozen_string_literal: true

module Commitlint
  # Linter class is responsible for linting commit messages.
  class Linter
    def initialize(commit_message, output: true)
      @commit_message = clean_commit_message(commit_message)
      @output = output
    end

    def lint!
      validator = Validator.new(@commit_message)

      if validator.valid?
        puts "Everything is look good!" if @output

        return 0
      end

      errors = validator.errors

      puts parse_errors(errors) if @output
      1
    end

    private

    def parse_errors(errors)
      <<~MESSAGE
        \nYour commit message is invalid:

        #{errors.map { |e| "=> #{e}" }.join("\n")}

        Get help: https://github.com/conventional-changelog/commitlint/#what-is-commitlint\n
      MESSAGE
    end

    def clean_commit_message(message)
      message.strip.gsub(/#.*$/, "").strip
    end
  end
end
