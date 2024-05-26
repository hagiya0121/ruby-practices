#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

PADDING = 4
COLUMN = 3
PERMISSION_SYMBOLS = ['---', '--x', '-w-', '-wx', 'r--', 'r-x', 'rw-', 'rwx'].freeze
FILETYPE_SYMBOLS = { file: '-', directory: 'd', link: 'l', characterSpecial: 'c',
                     blockSpecial: 'b', fifo: 'p', socket: 's' }.freeze

def main
  options = parse_options
  file_path = ARGV[0] || './'
  print_file(file_path, options) if File.file?(file_path)
  files = get_files(file_path, options)
  exit if files.empty?

  if options[:long]
    Dir.chdir(file_path) do
      file_stats = files.map { |file| get_file_stats(file) }
      print_long_files(file_stats)
    end
  else
    print_files(files, COLUMN)
  end
end

def parse_options
  options = { all: false, reverse: false, long: false }
  opt = OptionParser.new
  opt.on('-a') { |v| options[:all] = v }
  opt.on('-r') { |v| options[:reverse] = v }
  opt.on('-l') { |v| options[:long] = v }
  opt.parse!(ARGV)
  options
end

def print_file(file_path, options)
  if options[:long]
    file_stat = get_file_stats(file_path)
    print_long_files([file_stat])
  else
    puts file_path
  end
  exit
end

def get_files(file_path, options)
  files = if options[:all]
            Dir.entries(file_path).sort
          else
            Dir.chdir(file_path) { Dir.glob('*').sort }
          end
  files.reverse! if options[:reverse]
  files
end

def get_file_stats(file)
  file_stat = File.lstat(file)
  permission = file_stat.mode.to_s(8)[-3..]
  symbolic_permission = permission.chars.map { |char| PERMISSION_SYMBOLS[char.to_i] }.join
  file_type = file_stat.ftype.to_sym
  {
    block: file_stat.blocks,
    mode: FILETYPE_SYMBOLS[file_type] + symbolic_permission,
    link: file_stat.nlink.to_s,
    owner: Etc.getpwuid(file_stat.uid).name,
    group: Etc.getgrgid(file_stat.gid).name,
    size: file_stat.size.to_s,
    time: file_stat.atime.strftime('%-m %e %H:%M'),
    name: file_type == :link ? "#{file} -> #{File.readlink(file)}" : file
  }
end

def print_long_files(file_stats)
  max_lengths = get_max_lengths(file_stats)
  puts "total #{file_stats.sum { |stat| stat[:block] }}"
  file_stats.each do |stat|
    puts  "#{stat[:mode]}\s\s" \
          "#{stat[:link].rjust(max_lengths[:link])}\s" \
          "#{stat[:owner].ljust(max_lengths[:owner])}\s\s" \
          "#{stat[:group].ljust(max_lengths[:group])}\s\s" \
          "#{stat[:size].rjust(max_lengths[:size])}\s\s" \
          "#{stat[:time]}\s" \
          "#{stat[:name]}"
  end
end

def get_max_lengths(file_stats)
  keys = %i[link owner group size time]
  keys.map do |key|
    [key, file_stats.map { |stat| stat[key].length }.max]
  end.to_h
end

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

main
