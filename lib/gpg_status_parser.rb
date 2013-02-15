require 'gpg_status_parser/status_message'

module GPGStatusParser

  def self.parse_line(line)
    GPGStatusParser::StatusMessage.new(line)
  end

end
