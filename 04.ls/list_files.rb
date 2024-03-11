#!/usr/bin/env ruby
# frozen_string_literal: true

PADDING = 4
COLUMN = 3

file_path = ARGV[0] || './'
if File.file?(file_path)
  puts file_path
  exit
end

def get_directory_files(file_path)
  Dir.chdir(file_path) { Dir.glob('*').sort }
end

files = get_directory_files(file_path)
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
