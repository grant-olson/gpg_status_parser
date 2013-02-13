require 'gpg_status_parser'

File.open("status.txt").readlines.each do |line|
  next if line.nil?
  line = line.strip
  status = GPGStatusParser::StatusMessage.new(line)
  puts status.status
end
