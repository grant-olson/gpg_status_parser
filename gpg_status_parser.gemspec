Gem::Specification.new do |s|
  s.name = "gpg_status_parser"
  s.version = "0.0.0"
  s.date = "2013-02-12"
  s.summary = ""
  s.description = ""
  s.authors = ["Grant T. Olson"]
  s.email = "kgo@grant-olson.net"
  s.files = ["Rakefile",
             "lib/gpg_status_parser.rb",
             "lib/gpg_status_parser/status_codes.rb",
             "lib/gpg_status_parser/arguments.rb"]
  s.test_files = [
                  "test/test_status_message.rb",
                  "test/test_arguments.rb"
                 ]
  s.homepage = "https://github.com/grant-olson/gpg_status_parser"
end
