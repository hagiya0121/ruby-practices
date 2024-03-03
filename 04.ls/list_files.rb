#!/usr/bin/env ruby

files = Dir.entries('./test_dir1').sort
column = 3
col_files = files.size % column == 0 ? files.size / column : files.size / column + 1

slice_files = []
files.each_slice(col_files) do |file|
  slice_files << file
end

col_files.times do |col|
  column.times do |row|
    print slice_files[row][col], " "
  end
  puts
end