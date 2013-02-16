require 'test/unit'
require 'stringio'

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

  STATUS_TEXT = <<STATUS
[GNUPG:] PLAINTEXT 74 0 
[GNUPG:] SIG_ID jRWzDyjdbbGjvn9nNJJxF7HA7MA 2013-02-10 1360499004
[GNUPG:] GOODSIG 703B0C0E25D38721 Test User <test@example.org>
[GNUPG:] VALIDSIG B2AE14D84135BA08C0FC27C7703B0C0E25D38721 2013-02-10 1360499004 0 4 0 1 2 01 B2AE14D84135BA08C0FC27C7703B0C0E25D38721
[GNUPG:] TRUST_ULTIMATE
STATUS
  
  def test_parse_no_block
    status_file = StringIO.new(STATUS_TEXT)
    res = GPGStatusParser.parse(status_file).map{|msg| msg.status}
    good_res = [:PLAINTEXT, :SIG_ID, :GOODSIG, :VALIDSIG, :TRUST_ULTIMATE]
    assert (res == good_res), "Results didn't match expected"
  end
  
  def test_parse_block
    good_res = [:PLAINTEXT, :SIG_ID, :GOODSIG, :VALIDSIG, :TRUST_ULTIMATE].reverse

    status_file = StringIO.new(STATUS_TEXT)
    res = GPGStatusParser.parse(status_file) do |msg|
      assert (msg.status == good_res.pop), "Didn't match expected status"
    end
  end

  def test_parse_string_no_block
    res = GPGStatusParser.parse(STATUS_TEXT).map{|msg| msg.status}
    good_res = [:PLAINTEXT, :SIG_ID, :GOODSIG, :VALIDSIG, :TRUST_ULTIMATE]
    assert (res == good_res), "Results didn't match expected"
  end
  
  def test_parse_string_block
    good_res = [:PLAINTEXT, :SIG_ID, :GOODSIG, :VALIDSIG, :TRUST_ULTIMATE].reverse

    res = GPGStatusParser.parse(STATUS_TEXT) do |msg|
      assert (msg.status == good_res.pop), "Didn't match expected status"
    end
  end

  
end
