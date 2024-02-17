require 'date'
require 'optparse'

today = Date.today
month = today.month
year = today.year
opt = OptionParser.new
opt.on("-m", "--month MONTH", Integer, "月を指定") { |m| month = m }
opt.on("-y", "--year YEAR", Integer, "年を指定") { |y| year = y }
opt.parse!(ARGV)


puts "#{month}月 #{year}".center(20)
puts "日 月 火 水 木 金 土"
first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)
first_weekday_offset = first_date.wday * 3
print "\s" * first_weekday_offset
(first_date..last_date).each do |date|
  if date == today
    print "\e[7m#{date.day}\e[0m"
  else
    print "#{date.day}".rjust(2) + "\s"
  end
  puts "\n" if date.saturday?
end
puts "\n\n"
