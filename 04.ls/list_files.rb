#!/usr/bin/env ruby

file_path = ARGV[0] || './'
if File.file?(file_path)
  puts file_path
  exit
end
files = Dir.entries(file_path).sort.delete_if {|file| file.start_with?('.')}
column = 3
col_files = files.size % column == 0 ? files.size / column : files.size / column + 1


slice_files = files.each_slice(col_files).to_a if files.size != 0

max_length = slice_files.flatten.max_by {|name| name.length}.length

col_files.times do |col|
  slice_files.size.times do |row|
    print slice_files[row][col]&.ljust(max_length + 4)
  end
  puts
end