
$status_codes = {
  :NEWSIG => "",
  :GOODSIG => "<long_keyid_or_fpr>  <username>",
  :EXPSIG => "<long_keyid_or_fpr>  <username>",
  :EXPKEYSIG => "<long_keyid_or_fpr> <username>",
  :REVKEYSIG => "<long_keyid_or_fpr>  <username>",
  :BADSIG => "<long_keyid_or_fpr>  <username>",
  :ERRSIG => "<keyid>  <pkalgo> <hashalgo> <sig_class> <time> <rc>",
  :VALIDSIG => "<args>",
  :SIG_ID => "<radix64_string>  <sig_creation_date>  <sig-timestamp>",
  :ENC_TO => "<long_keyid>  <keytype>  <keylength>",
  :BEGIN_DECRYPTION => "",
  :END_DECRYPTION => "",
  :DECRYPTION_INFO => "<mdc_method> <sym_algo>",
  :DECRYPTION_FAILED => "",
  :DECRYPTION_OKAY => "",
  :SESSION_KEY => "<algo>:<hexdigits>",
  :BEGIN_ENCRYPTION => "<mdc_method> <sym_algo>",
  :END_ENCRYPTION => "",
  :FILE_START => "<what> <filename>",
  :FILE_DONE => "",
  :BEGIN_SIGNING => "",
  :ALREADY_SIGNED => "<long-keyid>",
  :SIG_CREATED => "<type> <pk_algo> <hash_algo> <class> <timestamp> <keyfpr>",
  :NOTATION_NAME => "<name>",
  :NOTATION_DATA => "<string>",
  :POLICY_URL => "<string>",
  :PLAINTEXT => "<format> <timestamp> <filename>",
  :PLAINTEXT_LENGTH => "<length>",
  :ATTRIBUTE => "<arguments>",
  :SIG_SUBPACKET => "<type> <flags> <len> <data>",
  :INV_RECP => "",
  :INV_SGNR => "",
  :NO_RECP => "<reserved>",
  :NO_SGNR => "<reserved>",
  :KEYEXPIRED => "<expire-timestamp>",
  :KEYREVOKED => "",
  :NO_PUBKEY => "<long keyid>",
  :NO_SECKEY => "<long keyid>",
  :KEY_CREATED => "<type> <fingerprint> [<handle>]",
  :KEY_NOT_CREATED => "[<handle>]",
  :TRUST_UNDEFINED => "<error_token>",
  :TRUST_NEVER => "<error_token>",
  :TRUST_MARGINAL => "[0 [<validation_model>]]",
  :TRUST_FULLY => "[0 [<validation_model>]]",
  :TRUST_ULTIMATE => "[0 [<validation_model>]]",
  :PKA_TRUST_GOOD => "<mailbox>",
  :PKA_TRUST_BAD => "<mailbox>",
  :GET_BOOL => "",
  :GET_LINE => "",
  :GET_HIDDEN => "",
  :GOT_IT => "",
  :USERID_HINT => "<long main keyid> <string>",
  :NEED_PASSPHRASE => "<long keyid> <long main keyid> <keytype> <keylength>",
  :NEED_PASSPHRASE_SYM => "<cipher_algo> <s2k_mode> <s2k_hash>",
  :NEED_PASSPHRASE_PIN => "<card_type> <chvno> [<serialno>]",
  :MISSING_PASSPHRASE => "",
  :BAD_PASSPHRASE => "<long keyid>",
  :GOOD_PASSPHRASE => "",
  :IMPORT_CHECK => "<long keyid> <fingerprint> <user ID>",
  :IMPORTED => "<long keyid>  <username>",
  :IMPORT_OK => "<reason> [<fingerprint>]",
  :IMPORT_PROBLEM => "<reason> [<fingerprint>]",
  :IMPORT_RES => "<args>",
  :CARDCTRL => "<what> [<serialno>]",
  :SC_OP_FAILURE => "[<code>]",
  :SC_OP_SUCCESS => "",
  :NODATA => "<what>",
  :UNEXPECTED => "<what>",
  :TRUNCATED => "<maxno>",
  :ERROR => "<error location> <error code> [<more>]",
  :SUCCESS => "[<location>]",
  :BADARMOR => "",
  :DELETE_PROBLEM => "<reason_code>",
  :PROGRESS => "<what> <char> <cur> <total>",
  :BACKUP_KEY_CREATED => "<fingerprint> <fname>",
  :MOUNTPOINT => "<name>",
  :PINENTRY_LAUNCHED => "<pid>"
}


NO_WHITESPACE = "[^\s]+"

argument_to_regexp = {
  "<long_keyid_or_fpr>"=>NO_WHITESPACE,
  "<username>"=>NO_WHITESPACE,
  "<keyid>"=>NO_WHITESPACE,
  "<pkalgo>"=>NO_WHITESPACE,
  "<hashalgo>"=>NO_WHITESPACE,
  "<sig_class>"=>NO_WHITESPACE,
  "<time>"=>NO_WHITESPACE,
  "<rc>"=>NO_WHITESPACE,
  "<args>"=>NO_WHITESPACE,
  "<radix64_string>"=>NO_WHITESPACE,
  "<sig_creation_date>"=>NO_WHITESPACE,
  "<sig-timestamp>"=>NO_WHITESPACE,
  "<long_keyid>"=>NO_WHITESPACE,
  "<keytype>"=>NO_WHITESPACE,
  "<keylength>"=>NO_WHITESPACE,
  "<mdc_method>"=>NO_WHITESPACE,
  "<sym_algo>"=>NO_WHITESPACE,
  "<algo>"=>NO_WHITESPACE,
  "<hexdigits>"=>NO_WHITESPACE,
  "<what>"=>NO_WHITESPACE,
  "<filename>"=>NO_WHITESPACE,
  "<long-keyid>"=>NO_WHITESPACE,
  "<type>"=>NO_WHITESPACE,
  "<pk_algo>"=>NO_WHITESPACE,
  "<hash_algo>"=>NO_WHITESPACE,
  "<class>"=>NO_WHITESPACE,
  "<timestamp>"=>NO_WHITESPACE,
  "<keyfpr>"=>NO_WHITESPACE,
  "<name>"=>NO_WHITESPACE,
  "<string>"=>NO_WHITESPACE,
  "<format>"=>NO_WHITESPACE,
  "<length>"=>NO_WHITESPACE,
  "<arguments>"=>NO_WHITESPACE,
  "<flags>"=>NO_WHITESPACE,
  "<len>"=>NO_WHITESPACE,
  "<data>"=>NO_WHITESPACE,
  "<reserved>"=>NO_WHITESPACE,
  "<expire-timestamp>"=>NO_WHITESPACE,
  "<long keyid>"=>NO_WHITESPACE,
  "<fingerprint>"=>NO_WHITESPACE,
  "<handle>"=>NO_WHITESPACE,
  "<error_token>"=>NO_WHITESPACE,
  "<validation_model>"=>NO_WHITESPACE,
  "<mailbox>"=>NO_WHITESPACE,
  "<long main keyid>"=>NO_WHITESPACE,
  "<cipher_algo>"=>NO_WHITESPACE,
  "<s2k_mode>"=>NO_WHITESPACE,
  "<s2k_hash>"=>NO_WHITESPACE,
  "<card_type>"=>NO_WHITESPACE,
  "<chvno>"=>NO_WHITESPACE,
  "<serialno>"=>NO_WHITESPACE,
  "<user ID>"=>NO_WHITESPACE,
  "<reason>"=>NO_WHITESPACE,
  "<code>"=>NO_WHITESPACE,
  "<maxno>"=>NO_WHITESPACE,
  "<error location>"=>NO_WHITESPACE,
  "<error code>"=>NO_WHITESPACE,
  "<more>"=>NO_WHITESPACE,
  "<location>"=>NO_WHITESPACE,
  "<reason_code>"=>NO_WHITESPACE,
  "<char>"=>NO_WHITESPACE,
  "<cur>"=>NO_WHITESPACE,
  "<total>"=>NO_WHITESPACE,
  "<fname>"=>NO_WHITESPACE,
  "<pid>"=>NO_WHITESPACE}

class NotGPGStatus < StandardError
end

class InvalidStatus < StandardError
end

class StatusMessage
  COMMAND_REGEXP = /^\[GNUPG:\] ([^ ]+)(?: (.*))?$/

  attr_reader :status, :args
  
  def initialize status_string
    match = COMMAND_REGEXP.match(status_string)
    raise NotGPGStatus if match.nil?

    @status = match[1].intern
    raise InvalidStatus if !$status_codes.keys.include?(@status)

    @args = match[2]
  end
end


File.open("status.txt").readlines.each do |line|
  next if line.nil?
  line = line.strip
  status = StatusMessage.new(line)
  puts status.status
end
