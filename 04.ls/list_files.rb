#!/usr/bin/env ruby

file_path = ARGV[0] || './'
(puts file_path; exit) if File.file?(file_path)

def get_directory_files(file_path)
  Dir.entries(file_path).sort.delete_if {|file| file.start_with?('.')}
end

files = get_directory_files(file_path)
exit if files.empty?

def print_files(files, column)
  row_count = (files.size.to_f / column).ceil
  max_length = files.max_by {|name| name.length}.length
  row_count.times do |index|
    column.times do
      print files[index]&.ljust(max_length + 4)
      index += row_count
    end
    puts
  end
end

print_files(files, 3)

