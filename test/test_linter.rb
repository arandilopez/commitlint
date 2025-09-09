# frozen_string_literal: true

class TestLinter < Minitest::Test
  def test_lint_valid_commit_message
    linter = Commitlint::Linter.new("feat: add new feature", output: false)
    assert_equal 0, linter.lint!
  end

  def test_lint_valid_commit_message_with_scope
    linter = Commitlint::Linter.new("feat(core): add new feature", output: false)
    assert_equal 0, linter.lint!
  end

  def test_lint_valid_commit_message_with_body
    valid_commit_message_with_body = <<~MESSAGE
      feat: add new feature

      Some description of the feature
    MESSAGE
    linter = Commitlint::Linter.new(valid_commit_message_with_body, output: false)
    assert_equal 0, linter.lint!
  end

  def test_lint_valid_commit_message_from_file
    file_with_valid_commit_message = "./test/fixtures/commit_msg"
    linter = Commitlint::Linter.new(File.read(file_with_valid_commit_message), output: false)
    assert_equal 0, linter.lint!
  end

  def test_lint_invalid_commit_message
    linter = Commitlint::Linter.new("invalid commit message", output: false)
    assert_equal 1, linter.lint!
  end

  def test_lint_empty_commit_message
    empty_commit_message = "\n# Comment message\n"
    linter = Commitlint::Linter.new(empty_commit_message, output: false)
    assert_equal 1, linter.lint!
  end

  def test_lint_invalid_type
    invalid_type = "new: new features"
    linter = Commitlint::Linter.new(invalid_type, output: false)
    assert_equal 1, linter.lint!
  end

  def test_lint_invalid_scope
    invalid_scope = "feat(x): new features"
    linter = Commitlint::Linter.new(invalid_scope, output: false)
    assert_equal 1, linter.lint!
  end

  def test_lint_invalid_subject
    invalid_subject = "feat: "
    linter = Commitlint::Linter.new(invalid_subject, output: false)
    assert_equal 1, linter.lint!
  end

  def test_deps_type
    message = "deps: update dependencies"
    linter = Commitlint::Linter.new(message, output: false)

    assert_equal 0, linter.lint!
  end
end
