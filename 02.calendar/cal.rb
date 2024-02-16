require 'date'
require 'optparse'

today = Date.today
month = today.month
year = today.year
opt = OptionParser.new
opt.on("-m", "--month MONTH", Integer, "月を指定") { |m| month = m }
opt.on("-y", "--year YEAR", Integer, "年を指定") { |y| year = y }
opt.parse!(ARGV)

week_day = Date.new(year, month, 1).wday
last_day = Date.new(year, month, -1).day
first_weekday_offset = week_day * 3

puts Date.today.strftime("%-m月 %Y").center(20)
puts "日 月 火 水 木 金 土"
print "\s" * first_weekday_offset
(1..last_day).each do |day|
  day = "\e[7m#{day}\e[0m" if day == today
  print "#{day}".rjust(2) + "\s"
  puts "\n" if week_day == 6
  week_day == 6 ? week_day = 0 : week_day += 1
end
puts "\n\n"
