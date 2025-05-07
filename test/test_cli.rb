# frozen_string_literal: true

class TestCli < Minitest::Test
  def test_cli_help_message
    assert system("exe/commitlint --help > /dev/null")
  end

  def test_cli_version_message
    assert system("exe/commitlint --version > /dev/null")
  end
end
