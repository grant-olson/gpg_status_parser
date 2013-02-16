require 'gpg_status_parser/status_message'

module GPGStatusParser

  # Parse a single line
  def self.parse_line(line)
    GPGStatusParser::StatusMessage.new(line.strip)
  end

  # Takes a file or string and optional block and either yields or
  # returns a list of status messages
  def self.parse(file_or_string, &block)
    if block
      file_or_string.each_line { |line| yield parse_line(line)}
    else
      file_or_string.each_line.map{ |line| parse_line(line)}
    end
  end

end
