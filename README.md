gpg_status_parser
=================

gpg provides a status interface that is designed to allow automated
systems to interact with it.  This library provides an interface that
translates the status strings into ruby objects to provide a more
natural way interface with gpg.

Quick Example
-------------

```ruby
require 'gpg_status_parser'
require 'tempfile'

signed_text = <<SIGNED
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

foo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJRF5E8AAoJEHA7DA4l04ch/oMH/RCB6UHYugL7br4oJX9+F7Iv
7QiNkWwTErQ499ZFZKHa4BCP6fJG9wXjqzfiu1YPbuiRdl52EgLHz/xHpu9Ewey8
0te9Evgume04wk+08+bihvdCtMtroDTNZ5nqF6/E4z1TPBfSvAvCNNLi1B7w+F5q
E10OwSt+bYa3aNBSc/Dt9t4Di0RsvvTCmVqV0actrKgdZt79nnvgsXTWuxIyZBqA
f5ACkN1KTR7eKa2fY7AojHcCqjHSK03AOMN35gcabuewKEBuVciXzyfp6bTyEHN1
PxBgZOQcWf70RA5pWZOyd+nLIeQ5pZmkWRzoxBt0FbcttNWWMRWGyGdpOtGpfDc=
=qO+n
-----END PGP SIGNATURE-----
SIGNED

# Save signed file
signed_file = Tempfile.new("signed")
signed_file.write(signed_text)
signed_file.close

# Create status file
status_file = Tempfile.new("status")

# Check sig

puts "NORMAL GPG OUTPUT"
puts "================="
puts
puts `gpg --status-file #{status_file.path} --verify #{signed_file.path}`

# Parse
status_messages = GPGStatusParser.parse(status_file)

# Print out msgs
puts
puts "PARSED STATUS MESSAGES"
puts "======================"
puts
status_messages.each { |msg| puts "#{msg.status} #{msg.args.inspect}" }

# Get sig status and trust
sig_status = nil
sig_trust = nil

validity_messages = [:GOODSIG, :EXPSIG, :BADSIG, :ERRSIG, :VALIDSIG]

trust_messages = [:TRUST_UNDEFINED, :TRUST_NEVER, :TRUST_MARGINAL,
                  :TRUST_FULLY, :TRUST_ULTIMATE]

status_messages.each do |msg|
  sig_status = msg.status if validity_messages.include? msg.status
  sig_trust = msg.status if trust_messages.include? msg.status
end

puts
puts "EXTRACTED VALIDITY AND TRUST"
puts "============================"
puts
puts "Signature validity was #{sig_status}"
puts "Signature trust level was #{sig_trust}"
# Clean up
signed_file.unlink

status_file.close
status_file.unlink
```

Example Output
--------------

```
NORMAL GPG OUTPUT
=================

gpg: Signature made Sun 10 Feb 2013 07:23:24 AM EST using RSA key ID 25D38721
gpg: Good signature from "Test User <test@example.org>"


PARSED STATUS MESSAGES
======================

SIG_ID {:radix64_string=>"jRWzDyjdbbGjvn9nNJJxF7HA7MA", :sig_creation_date=>"2013-02-10", :sig_timestamp=>"1360499004"}
GOODSIG {:long_keyid_or_fpr=>"703B0C0E25D38721", :username=>" Test User <test@example.org>"}
VALIDSIG {:fingerprint_in_hex=>"B2AE14D84135BA08C0FC27C7703B0C0E25D38721", :sig_creation_date=>"2013-02-10", :sig_timestamp=>"1360499004", :expire_timestamp=>"0", :sig_version=>"4", :reserved=>"0", :pubkey_algo=>"1", :hash_algo=>"2", :sig_class=>"01", :primary_key_fpr=>"B2AE14D84135BA08C0FC27C7703B0C0E25D38721"}
TRUST_ULTIMATE {}

EXTRACTED VALIDITY AND TRUST
============================

Signature validity was VALIDSIG
Signature trust level was TRUST_ULTIMATE


```