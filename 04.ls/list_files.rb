#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

PADDING = 4
COLUMN = 3

options = { all: false }
opt = OptionParser.new
opt.on('-a') { |v| options[:all] = v }
opt.parse!(ARGV)

file_path = ARGV[0] || './'
if File.file?(file_path)
  puts file_path
  exit
end

def get_directory_files(file_path)
  Dir.chdir(file_path) { Dir.glob('*').sort }
end

def get_directory_files_all(file_path)
  Dir.entries(file_path).sort
end

if options[:all]
  files = get_directory_files_all(file_path)
else
  files = get_directory_files(file_path)
end
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
