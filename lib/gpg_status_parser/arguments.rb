module GPGStatusParser::Arguments

  # Regexps to extract arguments should have two matchers, the actual
  # argument value and the rest minus whitespace
  NO_WHITESPACE = /([^\s]+)(.*)?/
  USERNAME = /(.+)()$/
  HEX = /([A-Z0-9]+)(.*)?/
  NUMBER = /(\d+)(.*)?/
  DATE = /(\d\d\d\d-\d\d-\d\d)(.*)?/

  ARGUMENTS = {
    :long_keyid_or_fpr => NO_WHITESPACE,
    :username => USERNAME,
    :keyid => NO_WHITESPACE,
    :pkalgo => NO_WHITESPACE,
    :hashalgo => NO_WHITESPACE,
    :sig_class => NO_WHITESPACE,
    :time => NO_WHITESPACE,
    :rc => NO_WHITESPACE,
    :args => NO_WHITESPACE,
    :radix64_string => NO_WHITESPACE,
    :sig_creation_date => DATE,
    :sig_version => NUMBER,
    :sig_timestamp => NUMBER,
    :long_keyid => NO_WHITESPACE,
    :keytype => NO_WHITESPACE,
    :keylength => NO_WHITESPACE,
    :mdc_method => NO_WHITESPACE,
    :sym_algo => NO_WHITESPACE,
    :algo => NO_WHITESPACE,
    :hexdigits => NO_WHITESPACE,
    :what => NO_WHITESPACE,
    :filename => NO_WHITESPACE,
    :long_keyid => NO_WHITESPACE,
    :type => NO_WHITESPACE,
    :pk_algo => NO_WHITESPACE,
    :hash_algo => NUMBER,
    :class => NO_WHITESPACE,
    :timestamp => NO_WHITESPACE,
    :keyfpr => NO_WHITESPACE,
    :name => NO_WHITESPACE,
    :string => NO_WHITESPACE,
    :format => NO_WHITESPACE,
    :length => NO_WHITESPACE,
    :arguments => NO_WHITESPACE,
    :flags => NO_WHITESPACE,
    :len => NO_WHITESPACE,
    :pubkey_algo => NUMBER,
    :data => NO_WHITESPACE,
    :reserved => NUMBER,
    :expire_timestamp => NUMBER,
    :long_keyid => HEX,
    :fingerprint => HEX,
    :primary_key_fpr => HEX,
    :fingerprint_in_hex => HEX,
    :handle => NO_WHITESPACE,
    :error_token => NO_WHITESPACE,
    :zero => /(0)(.*)/,
    :validation_model => NO_WHITESPACE,
    :mailbox => NO_WHITESPACE,
    :long_main_keyid => NO_WHITESPACE,
    :cipher_algo => NO_WHITESPACE,
    :s2k_mode => NO_WHITESPACE,
    :s2k_hash => NO_WHITESPACE,
    :card_type => NO_WHITESPACE,
    :chvno => NO_WHITESPACE,
    :serialno => NO_WHITESPACE,
    :user_ID => NO_WHITESPACE,
    :reason => NO_WHITESPACE,
    :code => NO_WHITESPACE,
    :maxno => NO_WHITESPACE,
    :error_location => NO_WHITESPACE,
    :error_code => NO_WHITESPACE,
    :more => NO_WHITESPACE,
    :location => NO_WHITESPACE,
    :reason_code => NO_WHITESPACE,
    :char => NO_WHITESPACE,
    :cur => NO_WHITESPACE,
    :total => NO_WHITESPACE,
    :fname => NO_WHITESPACE,
    :pid => NO_WHITESPACE,
    :count => NUMBER,
    :no_user_id => NUMBER,
    :imported => NUMBER,
    :imported_rsa => NUMBER,
    :unchanged => NUMBER,
    :n_uids => NUMBER,
    :n_sigs => NUMBER,
    :n_subk => NUMBER,
    :n_revoc => NUMBER,
    :sec_read => NUMBER,
    :sec_imported => NUMBER,
    :sec_dups => NUMBER,
    :skipped_new_keys => NUMBER,
    :not_imported => NUMBER
  }
  

  def self.extract_expected_argument argument_string
    argument_string = argument_string.strip

    return [nil, nil] if argument_string.empty?

    optional = false
    if argument_string[0] == "["
      optional = true
      argument_string = /[ ]*\[(.*)[ ]*\][ ]*$/.match(argument_string)[1]
    end
    

    matches = /<([^>]+)>(.*)/.match(argument_string)

    # make ruby-friendly symbols
    arg = matches[1].gsub(/[ -]/,"_")
    arg = arg.intern

    rest = matches[2]
    
    result = [arg, rest]
    result << :optional if optional

    result
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

  def self.extract_argument_values expected_args, argument_value_string
    return {} if expected_args.empty?

    results = []
    first, rest = expected_args[0], expected_args[1..-1]

    while first
      extract_re = ARGUMENTS[first]
      match = extract_re.match(argument_value_string)

      if match.nil?
        results << ""
        argument_value_string = ""
        first = nil
        rest = nil
      else
        results << match[1]
        argument_value_string = match[2]
        first, rest = rest[0], rest[1..-1]
      end
      
    end
    
    if argument_value_string && argument_value_string.length > 0
      warn "Actual args didnt match expected.  Extra stuff #{argument_value_string.inspect}"
    end
    
    # Delete unspecified optional args
    args = Hash[expected_args.zip(results)]
    args.delete_if {|key,val| val.nil? || val.empty?}
    args
  end
end
