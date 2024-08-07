# frozen_string_literal: true

require_relative './command'
require_relative './file_info'
require_relative './print_file'
require_relative './file_list'

class LsCommand
  def initialize(command)
    @command = command
  end

  def run
    file_list = FileList.new(@command.file_path, all: @command.options[:all])
    file_list.reverse if @command.options[:reverse]
    print_file = PrintFile.new(file_list)
    return print_file.print_file_path if @command.contain_file_name?

    if @command.options[:long]
      print_file.print_long_files
    else
      print_file.print_files
    end
  end
end

command = Command.new(ARGV)
LsCommand.new(command).run
