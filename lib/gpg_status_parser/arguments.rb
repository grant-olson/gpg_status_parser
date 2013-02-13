module GPGStatusParser::Arguments

  NO_WHITESPACE = "[^\s]+"

  ARGUMENTS = {
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

  def self.extract_expected_argument argument_string
    argument_string = argument_string.strip

    return [nil, nil] if argument_string.empty?
    
    raise "Optional Args not yet supported" if argument_string[0] == "["

    matches = /<([^>]+)>(.*)/.match(argument_string)
    arg = matches[1].gsub(" ","_").intern
    rest = matches[2]

    [arg, rest]
  end
  
  def self.extract_expected_arguments argument_string
    args = []
    first, rest = extract_expected_argument(argument_string)
    
    while (first || rest)
      args << first
      first, rest = extract_expected_argument(rest)
    end

    args
  end

end
