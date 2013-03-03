require 'gpg_status_parser/status_message'
require 'open3'

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

  # Run a gpg command, and take care of setting up and tearing down the
  # required temporary files.  Just pass in the arguments you want to send
  # to gpg:
  #
  #    GPGStatusParser.run_gpg("--verify foo.txt.asc foo.txt")
  #
  # and not:
  #
  #    GPGStatusParser.run_gpg("gpg --verify foo.txt.asc foo.txt")
  #
  # It is highly advised that you escape and/or scrub any user
  # generated input to make sure it is safe.  See Shellwords#shell_escape
  # in the ruby  standard library.
  def self.run_gpg args, data=nil, &block
    exit_status = nil
    status_file = Tempfile.new("status")

    full_gpg_command = "gpg --status-file #{status_file.path} #{args}"
    gpg_results = Open3.popen3(full_gpg_command) do |stdin, stdout, stderr, wait_thr|
      stdin.write data if data
      stdin.close
      exit_status = wait_thr.value
      parse(status_file, &block)
      out = stdout.read()
      err = stderr.read()
      {:status => exit_status, :stdout => out, :err => err}
    end
    gpg_results
  ensure
    status_file.close
    status_file.unlink
  end



end
