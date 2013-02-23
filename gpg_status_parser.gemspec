Gem::Specification.new do |s|
  s.name = "gpg_status_parser"
  s.version = "0.4.0.pre"
  s.date = "2013-02-23"
  s.summary = "Turns gpg status messages into ruby objects."
  s.description = "Turns structured status messages provided by gpg into ruby objects for easy manipulation in your code."
  s.authors = ["Grant T. Olson"]
  s.email = "kgo@grant-olson.net"
  s.files = ["LICENSE",
             "Rakefile",
             "lib/gpg_status_parser.rb",
             "lib/gpg_status_parser/status_codes.rb",
             "lib/gpg_status_parser/arguments.rb",
             "lib/gpg_status_parser/status_message.rb"
            ]
  s.test_files = [
                  "test/test_status_message.rb",
                  "test/test_arguments.rb",
                  "test/test_main_api.rb"
                 ]
  s.homepage = "https://github.com/grant-olson/gpg_status_parser"
  s.license = "BSD 3 Clause"
end
