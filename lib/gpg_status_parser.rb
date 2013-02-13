require 'gpg_status_parser/status_codes'

module GPGStatusParser
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
      raise InvalidStatus if !STATUS_CODES.keys.include?(@status)

      @args = match[2]
    end
  end
end
