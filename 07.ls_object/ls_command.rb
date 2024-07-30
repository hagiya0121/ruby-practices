# frozen_string_literal: true

require_relative './command'
require_relative './file_info'
require_relative './print_file'

class LsCommand
  def initialize(command)
    @command = command
  end

  def run
    files = fetch_files
    files_info = files.map { |file| FileInfo.new(file) }
    PrintFile.print_files(files_info)
  end

  private

  def fetch_files
    options = @command.options
    file_path = @command.file_path
    files = if options[:all]
      Dir.entries(file_path).sort
    else
      Dir.chdir(file_path) { Dir.glob('*').sort }
    end

    files.reverse! if options[:reverse]
    files
  end
end

command = Command.new(ARGV)
LsCommand.new(command).run
