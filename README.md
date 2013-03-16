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

# Check sig

puts "NORMAL GPG OUTPUT"
puts "================="
puts
puts `gpg --verify #{signed_file.path}`

# Lets save the validity and trust messages
sig_status = nil
sig_trust = nil

validity_messages = [:GOODSIG, :EXPSIG, :BADSIG, :ERRSIG, :VALIDSIG]

trust_messages = [:TRUST_UNDEFINED, :TRUST_NEVER, :TRUST_MARGINAL,
                  :TRUST_FULLY, :TRUST_ULTIMATE]

GPGStatusParser.run_gpg("--verify #{signed_file.path}") do |msg|
  puts "RECEIVED: #{msg.status} #{msg.args.inspect}"

  sig_status = msg.status if validity_messages.include? msg.status
  sig_trust = msg.status if trust_messages.include? msg.status
end

puts
puts "EXTRACTED VALIDITY AND TRUST"
puts "============================"
puts
puts "Signature validity was #{sig_status}"
puts "Signature trust level was #{sig_trust}"
```

Example Output
--------------

```
NORMAL GPG OUTPUT
=================

gpg: Signature made Sun 10 Feb 2013 07:23:24 AM EST using RSA key ID 25D38721
gpg: Good signature from "Test User <test@example.org>"

RECEIVED: SIG_ID {:radix64_string=>"jRWzDyjdbbGjvn9nNJJxF7HA7MA", :sig_creation_date=>"2013-02-10", :sig_timestamp=>"1360499004"}
RECEIVED: GOODSIG {:long_keyid_or_fpr=>"703B0C0E25D38721", :username=>" Test User <test@example.org>"}
RECEIVED: VALIDSIG {:fingerprint_in_hex=>"B2AE14D84135BA08C0FC27C7703B0C0E25D38721", :sig_creation_date=>"2013-02-10", :sig_timestamp=>"1360499004", :expire_timestamp=>"0", :sig_version=>"4", :reserved=>"0", :pubkey_algo=>"1", :hash_algo=>"2", :sig_class=>"01", :primary_key_fpr=>"B2AE14D84135BA08C0FC27C7703B0C0E25D38721"}
RECEIVED: TRUST_ULTIMATE {}

EXTRACTED VALIDITY AND TRUST
============================

Signature validity was VALIDSIG
Signature trust level was TRUST_ULTIMATE
```

Verification
------------

This gem is signed with rubygems-openpgp.  You can verify its
integrity by running:

    gem install gpg_status_parser --verify

Much more information on signing is available at the [rubygems-openpgp
Certificate Authority](https://www.rubygems-openpgp-ca.org).


Signing key:

    pub   2048R/E3B5806F 2010-01-11 [expires: 2014-01-03]
          Key fingerprint = A530 C31C D762 0D26 E2BA  C384 B6F6 FFD0 E3B5 806F
    uid                  Grant T. Olson (Personal email) <kgo@grant-olson.net>
    uid                  Grant T Olson <grant@webkite.com>
    uid                  Grant T. Olson (pikimal) <grant@pikimal.com>
    sub   2048R/6A8F7CF6 2010-01-11 [expires: 2014-01-03]
    sub   2048R/A18A54D6 2010-03-01 [expires: 2014-01-03]
    sub   2048R/D53982CE 2010-08-31 [expires: 2014-01-03]
