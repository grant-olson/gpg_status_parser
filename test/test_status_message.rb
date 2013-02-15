require 'test/unit'
require 'gpg_status_parser'

class StatusMessageTest < Test::Unit::TestCase
  def test_sig_id
    sig_id_msg = "[GNUPG:] SIG_ID jRWzDyjdbbGjvn9nNJJxF7HA7MA 2013-02-10 1360499004"
    msg = GPGStatusParser::StatusMessage.new(sig_id_msg)

    assert (msg.status == :SIG_ID), "extracted status should be SIG_ID"

    args = {
      :radix64_string=>"jRWzDyjdbbGjvn9nNJJxF7HA7MA",
      :sig_creation_date=>"2013-02-10",
      :sig_timestamp=>"1360499004"
    }
    assert (msg.args == args), "Args didn't match"
  end

  def test_goodsig
    goodsig_msg = "[GNUPG:] GOODSIG 703B0C0E25D38721 Test User <test@example.org>"
    msg = GPGStatusParser::StatusMessage.new(goodsig_msg)

    assert (msg.status == :GOODSIG), "status should be :GOODSIG"

    args = {
      :long_keyid_or_fpr=>"703B0C0E25D38721",
      :username=>" Test User <test@example.org>"
    }
    assert (msg.args == args), "Wrong args"
  end

  def test_validsig
    unparsed_msg = "[GNUPG:] VALIDSIG B2AE14D84135BA08C0FC27C7703B0C0E25D38721 2013-02-10 1360499004 0 4 0 1 2 01 B2AE14D84135BA08C0FC27C7703B0C0E25D38721"
    msg = GPGStatusParser::StatusMessage.new(unparsed_msg)

    assert (msg.status == :VALIDSIG), ""

    args = {
      :fingerprint_in_hex=>"B2AE14D84135BA08C0FC27C7703B0C0E25D38721",
      :sig_creation_date=>"2013-02-10", :sig_timestamp=>"1360499004",
      :expire_timestamp=>"0", :sig_version=>"4", :reserved=>"0",
      :pubkey_algo=>"1", :hash_algo=>"2", :sig_class=>"01",
      :primary_key_fpr=>"B2AE14D84135BA08C0FC27C7703B0C0E25D38721"
    }
    assert (msg.args == args), "#{msg.args.inspect}"
  end
  
  def test_trust_ultimate
    unparsed_msg = "[GNUPG:] TRUST_ULTIMATE"
    msg = GPGStatusParser::StatusMessage.new(unparsed_msg)

    assert (msg.status == :TRUST_ULTIMATE), "expected :TRUST_ULTIMATE"

    args = {:zero=>"", :validation_model=>nil}
    assert (msg.args == args), "#{msg.args.inspect}"
  end
  
  def test_sig_id_2
    unparsed_msg = "[GNUPG:] SIG_ID kEOcXvBQzVQilo+AYc+Ws8Mutok 2011-05-28 1306618646"
    msg = GPGStatusParser::StatusMessage.new(unparsed_msg)

    assert (msg.status == :SIG_ID), "expected :SIG_ID"

    args = {
      :radix64_string=>"kEOcXvBQzVQilo+AYc+Ws8Mutok",
      :sig_creation_date=>"2011-05-28",
      :sig_timestamp=>"1306618646"
    }
    assert (msg.args == args), "#{msg.args.inspect}"
  end
  
  def test_goodsig_2
    unparsed_msg = "[GNUPG:] GOODSIG FE45E55DA18A54D6 Grant T. Olson (Personal email) <kgo@grant-olson.net>"
    msg = GPGStatusParser::StatusMessage.new(unparsed_msg)

    assert (msg.status == :GOODSIG), "Expected :GOODSIG"

    args = {
      :long_keyid_or_fpr=>"FE45E55DA18A54D6",
      :username=>" Grant T. Olson (Personal email) <kgo@grant-olson.net>"
    }
    assert (msg.args == args), "#{msg.args.inspect}"
  end
  
  def test_valid_sig_2
    unparsed_msg = "[GNUPG:] VALIDSIG F64DB95B20F8BA9B68B34346FE45E55DA18A54D6 2011-05-28 1306618646 0 4 0 1 3 00 A530C31CD7620D26E2BAC384B6F6FFD0E3B5806F"
    msg = GPGStatusParser::StatusMessage.new(unparsed_msg)

    assert (msg.status == :VALIDSIG), "expected :VALIDSIG"

    args = {
      :fingerprint_in_hex=>"F64DB95B20F8BA9B68B34346FE45E55DA18A54D6",
      :sig_creation_date=>"2011-05-28", :sig_timestamp=>"1306618646",
      :expire_timestamp=>"0", :sig_version=>"4", :reserved=>"0",
      :pubkey_algo=>"1", :hash_algo=>"3", :sig_class=>"00",
      :primary_key_fpr=>"A530C31CD7620D26E2BAC384B6F6FFD0E3B5806F"
    }
    assert (msg.args == args), "#{msg.args.inspect}"
  end
  
  def test_trust_undefined
    unparsed_msg = "[GNUPG:] TRUST_UNDEFINED"
    msg = GPGStatusParser::StatusMessage.new(unparsed_msg)

    assert (msg.status == :TRUST_UNDEFINED), "Expected TRUST_UNDEFINED"

    args = {:error_token=>""}
    assert (msg.args == args), "#{msg.args.inspect}"
  end
  
  
end
