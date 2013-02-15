require 'test/unit'
require 'gpg_status_parser'
require 'gpg_status_parser/arguments'

class ArgumentsTest < Test::Unit::TestCase

  def test_expected_argument_extraction
    GPGStatusParser::STATUS_CODES.each_pair do |key, val|
      assert_nothing_raised do
        GPGStatusParser::Arguments.extract_expected_arguments(val)
      end
    end
  end
  
end
