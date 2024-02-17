#!/usr/bin/env ruby
require 'date'
require 'optparse'

today = Date.today
options = { month: today.month, year: today.year}
opt = OptionParser.new
opt.on("-m", "--month MONTH", Integer, "月を指定") { |month| options[:month] = month }
opt.on("-y", "--year YEAR", Integer, "年を指定") { |year| options[:year] = year }
opt.parse!(ARGV)

puts "#{options[:month]}月 #{options[:year]}".center(20)
puts "日 月 火 水 木 金 土"

first_date = Date.new(options[:year], options[:month], 1)
last_date = Date.new(options[:year], options[:month], -1)
print " " * first_date.wday * 3
(first_date..last_date).each do |date|
  if date == today
    print "\e[7m#{date.day}\e[0m"
  else
    print "#{date.day}".rjust(2) + " "
  end
  puts "\n" if date.saturday?
end
puts "\n\n"
