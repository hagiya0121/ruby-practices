#!/usr/bin/env ruby

files = Dir.entries('./test_dir1').sort.delete_if {|file| file.start_with?('.')}
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