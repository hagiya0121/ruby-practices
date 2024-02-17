require 'date'
require 'optparse'

today = Date.today
month = today.month
year = today.year
opt = OptionParser.new
opt.on("-m", "--month MONTH", Integer, "月を指定") { |m| month = m }
opt.on("-y", "--year YEAR", Integer, "年を指定") { |y| year = y }
opt.parse!(ARGV)

first_weekday = Date.new(year, month, 1).wday
last_day = Date.new(year, month, -1).day
first_weekday_offset = first_weekday * 3

puts "#{month}月 #{year}".center(20)
puts "日 月 火 水 木 金 土"
print "\s" * first_weekday_offset
(1..last_day).each do |day|
  is_today = today.year == year && today.month == month && today.day == day
  day = "\e[7m#{day}\e[0m" if is_today
  print "#{day}".rjust(2) + "\s"
  puts "\n" if first_weekday == 6
  first_weekday == 6 ? first_weekday = 0 : first_weekday += 1
end
puts "\n\n"
