#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

PADDING = 4
COLUMN = 3
PERMISSION_SYMBOLS = ['---', '--x', '-w-', '-wx', 'r--', 'r-x', 'rw-', 'rwx'].freeze
FILETYPE_SYMBOLS = { file: '-', directory: 'd', link: 'l', characterSpecial: 'c',
                     blockSpecial: 'b', fifo: 'p', socket: 's' }.freeze

options = { all: false, reverse: false, long: false }
opt = OptionParser.new
opt.on('-a') { |v| options[:all] = v }
opt.on('-r') { |v| options[:reverse] = v }
opt.on('-l') { |v| options[:long] = v }
opt.parse!(ARGV)

file_path = ARGV[0] || './'
if File.file?(file_path)
  puts file_path
  exit
end

files = if options[:all]
          Dir.entries(file_path).sort
        else
          Dir.chdir(file_path) { Dir.glob('*').sort }
        end

def convert_permission_to_symbol(file)
  numeric_permission = File::Stat.new(file).mode.to_s(8)[-3..]
  numeric_permission.chars.map { |char| PERMISSION_SYMBOLS[char.to_i] }.join
end

def convert_filetype_to_symbol(file)
  file_type = File::Stat.new(file).ftype.to_sym
  FILETYPE_SYMBOLS[file_type]
end

Dir.chdir(file_path) do
  files.each do |file|
    puts convert_filetype_to_symbol(file) + convert_permission_to_symbol(file)
  end
end

files.reverse! if options[:reverse]
exit if files.empty?

def print_files(files, column)
  row_count = (files.size.to_f / column).ceil
  max_length = files.max_by(&:length).length
  row_count.times do |index|
    column.times do
      print files[index]&.ljust(max_length + PADDING)
      index += row_count
    end
    puts
  end
end

print_files(files, COLUMN)
