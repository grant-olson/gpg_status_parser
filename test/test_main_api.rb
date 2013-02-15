require 'test/unit'

class MainApiTest < Test::Unit::TestCase
  def test_parse_line
        sig_id_msg = "[GNUPG:] SIG_ID jRWzDyjdbbGjvn9nNJJxF7HA7MA 2013-02-10 1360499004"
    msg = GPGStatusParser::parse_line(sig_id_msg)

    assert (msg.status == :SIG_ID), "extracted status should be SIG_ID"

    args = {
      :radix64_string=>"jRWzDyjdbbGjvn9nNJJxF7HA7MA",
      :sig_creation_date=>"2013-02-10",
      :sig_timestamp=>"1360499004"
    }
    assert (msg.args == args), "Args didn't match"
  end

  def test_parse_line_not_status_line
    assert_raise GPGStatusParser::NotGPGStatus do
      GPGStatusParser.parse_line("sfdsdfdsaf")
    end
  end
  
  def test_parse_line_invalid_status
    assert_raise GPGStatusParser::InvalidStatus do
      GPGStatusParser.parse_line("[GNUPG:] X509SIG_ID jRWzDyjdbbGjvn9nNJJxF7HA7MA 2013-02-10 1360499004")
    end
  end
  
  
end
