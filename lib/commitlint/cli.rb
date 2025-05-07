# frozen_string_literal: true

require "optparse"

module Commitlint
  # Cli class is responsible for handling command line arguments
  class Cli
    BANNER = <<~HELP.freeze
      Commintlint v#{Commitlint::VERSION} - A CLI tool to lint commit messages with Conventional Commits.

      Usage: commitlint --message [commit_message | filepath]

      Examples:
        commitlint --message "feat: add new feature"
        commitlint --message "./path/to/commit_msg"
        commitlint --message ".git/COMMIT_EDITMSG"

      Options:
    HELP

    def initialize(argv)
      @argv = argv
      @options = {
        message: nil,
        quiet: false
      }
    end

    def self.start(argv)
      new(argv).run
    end

    def run
      @argv << "-h" if @argv.empty?
      parse_options!

      return 0 if @options[:message].nil?

      message = parse_input(@options[:message])
      linter = Linter.new(message, output: !@options[:quite])

      linter.lint!
    end

    private

    def parse_options!
      opt_parser = OptionParser.new do |opts|
        opts.banner = BANNER
        opts.on("-m", "--message MSG", "Commit message or file path, fallbacks to `.git/COMMIT_EDITMSG`") do |message|
          @options[:message] = message.nil? ? ".git/COMMIT_EDITMSG" : message
        end

        opts.on("-q", "--quiet", "Suppress output") { @options[:quiet] = true }
        opts.on("-h", "--help", "Show this help message") { puts opts }
        opts.on("-v", "--version", "Show version") { puts Commitlint::VERSION }
      end

      opt_parser.parse!(@argv)
    end

    def parse_input(input)
      File.exist?(input) ? File.read(input) : input
    end
  end
end
