#!/usr/bin/env ruby

file_path = ARGV[0] || './'
(puts file_path; exit) if File.file?(file_path)

files = Dir.entries(file_path).sort.delete_if {|file| file.start_with?('.')}
exit if files.size == 0

def max_length(files)
  files.max_by {|name| name.length}.length
end

def print_files(files, column)
  output_rows = files.size % column == 0 ? files.size / column : files_count / column + 1
  slice_files = files.each_slice(output_rows).to_a

  output_rows.times do |col|
    slice_files.size.times do |row|
      print slice_files[row][col]&.ljust(max_length(files) + 4)
    end
    puts
  end
end

print_files(files, 3)
