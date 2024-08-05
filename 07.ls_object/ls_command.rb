# frozen_string_literal: true

require_relative './command'
require_relative './file_info'
require_relative './print_file'

class LsCommand
  def initialize(command)
    @command = command
  end

  def run
    return PrintFile.print_file_path(@command.file_path) if @command.contain_file_name?

    Dir.chdir(@command.file_path) do
      files_info = fetch_files.map { |file| FileInfo.new(file) }
      if @command.options[:long]
        PrintFile.print_long_files(files_info)
      else
        PrintFile.print_files(files_info)
      end
    end
  end

  private

  def fetch_files
    files = if @command.options[:all]
              Dir.entries(@command.file_path).sort
            else
              Dir.glob('*').sort
            end

    files.reverse! if @command.options[:reverse]
    files
  end
end

command = Command.new(ARGV)
LsCommand.new(command).run
