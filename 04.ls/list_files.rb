#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

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

def print_long_files(file_stats)
  max_length = ->(key) { file_stats.map { |stat| stat[key].length }.max }
  max_length_link = max_length.call(:link)
  max_length_size = max_length.call(:size)
  max_length_owner = max_length.call(:owner)
  max_length_group = max_length.call(:group)
  max_length_time = max_length.call(:time)

  puts "total #{file_stats.sum { |stat| stat[:block] }}"
  file_stats.each do |stat|
    mode = stat[:mode]
    link = stat[:link].rjust(max_length_link)
    owner = stat[:owner].ljust(max_length_owner)
    group = stat[:group].ljust(max_length_group)
    size = stat[:size].rjust(max_length_size)
    time = stat[:time].rjust(max_length_time)
    name = stat[:name]
    puts "#{mode}  #{link} #{owner}  #{group}  #{size}  #{time} #{name}"
  end
end

file_stats = []

Dir.chdir(file_path) do
  files.each do |file|
    file_stat = File::Stat.new(file)
    permission = file_stat.mode.to_s(8)[-3..]
    symbolic_permission = permission.chars.map { |char| PERMISSION_SYMBOLS[char.to_i] }.join
    file_type = file_stat.ftype.to_sym
    symbolic_filetype = FILETYPE_SYMBOLS[file_type]

    file_stats << {
      mode: symbolic_filetype + symbolic_permission,
      size: file_stat.size.to_s,
      link: file_stat.nlink.to_s,
      owner: Etc.getpwuid(file_stat.uid).name,
      group: Etc.getgrgid(file_stat.gid).name,
      time: file_stat.atime.strftime('%-m %e %H:%M'),
      block: file_stat.blocks,
      name: file
    }
  end
  print_long_files(file_stats)
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

# print_files(files, COLUMN)
