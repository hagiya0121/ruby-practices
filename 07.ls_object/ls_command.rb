# frozen_string_literal: true

require 'optparse'
require_relative './file_info'
require_relative './print_file'
require_relative './file_list'

class LsCommand
  def initialize(argv)
    @options = parse_options(argv)
    @file_path = argv.first || './'
  end

  def run
    file_list = FileList.new(@file_path, @options[:all])
    file_list.reverse! if @options[:reverse]
    print_file = FileListPrinter.new(file_list)
    return print_file.print_file_path if File.file?(@file_path)

    if @options[:long]
      print_file.print_long_files
    else
      print_file.print_files
    end
  end

  private

  def parse_options(argv)
    options = { all: false, reverse: false, long: false }
    opt = OptionParser.new
    opt.on('-a') { |v| options[:all] = v }
    opt.on('-r') { |v| options[:reverse] = v }
    opt.on('-l') { |v| options[:long] = v }
    opt.parse!(argv)
    options
  end
end

LsCommand.new(ARGV).run
