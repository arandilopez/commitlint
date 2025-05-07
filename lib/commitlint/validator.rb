# frozen_string_literal: true

module Commitlint
  # Validator class is responsible for validating commit messages
  # and elements inside the message to comply with Conventional Commit schema.
  class Validator
    attr_reader :errors

    def initialize(commit_message)
      @commit_message = commit_message
      @has_validated = false
      @errors = []
    end

    def valid?
      validate!

      errors.empty?
    end

    def validate!
      return if @has_validated

      commit_message_not_empty?
      valid_format?
      valid_type?
      valid_scope?
      subject_not_empty?

      @has_validated = true
    end

    def commit_message_not_empty?
      @errors << "Commit message cannot be empty." if @commit_message.empty?
    end

    def valid_format?
      @matches = @commit_message.match(Commitlint::CONVENTIONAL_COMMIT_SCHEMA)

      @errors << "Invalid commit message format." unless @matches
    end

    def valid_scope?
      invalid_scope = @matches && @matches[:scope] && @matches[:scope].size < 2
      @errors << "Scope is invalid. Must be at least 2 characters" if invalid_scope
    end

    def valid_type?
      valid_type = @matches && @matches[:type] && Commitlint::VALID_TYPES.include?(@matches[:type])
      @errors << "Type is invalid, must be one of \"#{Commitlint::VALID_TYPES.join(", ")}\"." unless valid_type
    end

    def subject_not_empty?
      @errors << "Subject is empty." if @matches && (@matches[:subject].nil? || @matches[:subject].empty?)
    end
  end
end
