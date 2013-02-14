require 'gpg_status_parser'
require 'gpg_status_parser/arguments'

File.open("status.txt").readlines.each do |line|
  next if line.nil?
  line = line.strip
  status = GPGStatusParser::StatusMessage.new(line)
  puts "#{status.status} #{status.args.inspect}"
end

#GPGStatusParser::STATUS_CODES.each_pair do |key, val|
#  begin
#    puts GPGStatusParser::Arguments.extract_expected_arguments(val).inspect
#  rescue Exception => ex
#    puts "PASS #{ex.message}"
#  end
# end
  
